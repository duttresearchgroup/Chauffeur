from prometheus_api_client import PrometheusConnect
import pandas as pd
import docker

# import subprocess
# import json

class MemMonitor:
    def __init__(self, container_name, label):
        self.container_name = container_name
        self.profile_dict = {}
        self.data = pd.DataFrame()
        self.dataset_dir = container_name
        self.label = label
        client = docker.from_env()
        self.container = client.containers.get(container_name)

    def sample(self):
        usage = self.container.stats(decode=False,stream=False)['memory_stats']['usage']

        if usage is not None:
            self.profile_dict['usage'] = [usage]
        
        if self.profile_dict != {}:
            self.profile_dict['label'] = [self.label]
            new_row = pd.DataFrame(self.profile_dict)
            self.data = pd.concat([self.data, new_row])
            self.data.to_csv(self.dataset_dir + "/mem_time_series.csv")