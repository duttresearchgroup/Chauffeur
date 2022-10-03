from prometheus_api_client import PrometheusConnect
import json
import pandas as pd

class CpuMonitor:
    def __init__(self, container_name, label):
        self.container_name = f'"{container_name}"'
        self.metrics = []
        self.profile_dict = {}
        self.data = pd.DataFrame()
        self.dataset_dir = container_name
        self.label = label

    def sample(self):
        prom = PrometheusConnect(url ="http://localhost:9090", disable_ssl=True)
        cpu_usage_query = "rate(container_cpu_usage_seconds_total{name=" + self.container_name + "}[5s])"
        self.metrics = prom.custom_query(query=cpu_usage_query)
        
        if self.metrics is not None:
            for metric in self.metrics:
                metric = str(metric).replace("\'", "\"")
                metric = json.loads(metric)
                cpu_core = metric['metric']['cpu']
                usage = metric['value'][1]
                self.profile_dict[cpu_core] = [usage]
                
        if self.profile_dict != {}:
            self.profile_dict['label'] = [self.label]
            new_row = pd.DataFrame(self.profile_dict)
            self.data = pd.concat([self.data, new_row])
            self.data.to_csv(self.dataset_dir + "/cpu_time_series.csv") 
