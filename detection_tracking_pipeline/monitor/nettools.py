from prometheus_api_client import PrometheusConnect
import json
from datetime import datetime
import pandas as pd
import os

class NetMonitor:
    def __init__(self, container_name, label):
        self.container_name = f'"{container_name}"'
        self.metrics_1 = []
        self.metrics_2 = []
        self.profile_dict = {}
        self.data = pd.DataFrame()
        self.dataset_dir = container_name
        self.label = label
        self.times = 0

    def sample(self):
        prom = PrometheusConnect(url ="http://localhost:9090", disable_ssl=True)
        net_transmit_query = "rate(container_network_transmit_bytes_total{name=" + self.container_name + "}[5s])"
        net_receive_query = "rate(container_network_receive_packets_total{name=" + self.container_name + "}[5s])"
        
        self.metrics_1 = prom.custom_query(query=net_transmit_query)
        self.metrics_2 = prom.custom_query(query=net_receive_query)

        if self.metrics_1 is not None:
            for metric in self.metrics_1:
                metric = str(metric).replace("\'", "\"")
                metric = json.loads(metric)
                interface = metric['metric']['interface']
                timestamp, usage = metric['value'][0], metric['value'][1]
                self.profile_dict['timestamp'] = [timestamp]
                self.profile_dict[interface + "-transmit"] = [usage]

        if self.metrics_2 is not None:
            for metric in self.metrics_2:
                metric = str(metric).replace("\'", "\"")
                metric = json.loads(metric)
                interface = metric['metric']['interface']
                timestamp, usage = metric['value'][0], metric['value'][1]
                self.profile_dict['timestamp'] = [timestamp]
                self.profile_dict[interface + "-receive"] = [usage]

        if self.profile_dict != {}:
            self.profile_dict['label'] = [self.label]
            
            if os.path.exists(self.dataset_dir + "/net_time_series.csv"):
                self.data = pd.read_csv(self.dataset_dir + "/net_time_series.csv")
              
            new_row = pd.DataFrame(self.profile_dict)
            self.data = pd.concat([self.data, new_row])
            self.data.to_csv(self.dataset_dir + "/net_time_series.csv", index=False) 