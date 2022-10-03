from prometheus_api_client import PrometheusConnect, MetricsList, Metric
import cputools
import memtools
import nettools
import time
import multiprocessing 
import sys
import os
import argparse
import signal

class Abnormal():
    def __init__(self):
        self.value = True

    def handler(self,signum, frame):
        if self.value:
            self.value = False
        else:
            self.value = True

def Monitor(container_name, sleep_time, label, running_time):
    abnormal = Abnormal()
    if abnormal.value:
        sleep_time = 1/10
        label = 1
    else:
        sleep_time = 1/30
        label = 0
    signal.signal(signal.SIGINT, abnormal.handler)
    if not os.path.isdir(container_name):
        os.mkdir(container_name)    
    
    start_time = time.time() 
    cpu_detection_monitor = cputools.CpuMonitor(container_name, label)
    mem_detection_monitor = memtools.MemMonitor(container_name, label)
    net_detection_monitor = nettools.NetMonitor(container_name, label)

    while True:
        # print("im running")
        # print(container_name)
        # # print(sleep_time)
        # print(label)
        # print(running_time)
        if abnormal.value:
            sleep_time = 1/10
            label = 1
        else:
            sleep_time = 1/30
            label = 0
        # print(sleep_time)
        # print(label)
        cpu_detection_monitor.label = label
        mem_detection_monitor.label = label
        net_detection_monitor.label = label

        current_time = time.time()
        elapsed_time = current_time - start_time

        if elapsed_time > float(running_time):
            print("finish generate dataset from " + container_name) 
            break 
        try:
            time.sleep(float(sleep_time))
            cpu_detection_monitor.sample()
            mem_detection_monitor.sample()
            net_detection_monitor.sample()

        except KeyboardInterrupt:
            sys.exit(0)

if __name__ == "__main__":
    def handler(signum, frame):
        print("hello")
    signal.signal(signal.SIGINT, handler)
    parser = argparse.ArgumentParser(description='Time series data generater')
    parser.add_argument("-l", "--label", help="input video name", required=True)
    parser.add_argument("-i", "--sample_interval", help="sample interval", required=True)
    parser.add_argument("-t", "--time", help="running time", required=True)
    args = parser.parse_args()

    monitor_containers = ["vehicle_detection_and_tracking_pipeline_detector_1" \
                        , "vehicle_detection_and_tracking_pipeline_detector_1"]

    p1 = multiprocessing.Process(target=Monitor, args=("vehicle_detection_and_tracking_pipeline_detector_1" \
                                                        , args.sample_interval\
                                                        , args.label \
                                                        , args.time))

    p2 = multiprocessing.Process(target=Monitor, args=("vehicle_detection_and_tracking_pipeline_tracker_1" \
                                                        , float(args.sample_interval) \
                                                        , args.label \
                                                        , args.time))
    p1.start()
    p2.start()
    p1.join()
    p2.join()

    
    
