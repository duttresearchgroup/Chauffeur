import zmq
import cv2
from io import BytesIO
import numpy as np
import sys
import os
import argparse
import time
from custom_timer import *
import multiprocessing
import glob
import subprocess
import signal
import docker
from subprocess import call, run



def run_monitor(client,monitor_container):
    # client.api.kill(monitor_container.short_id, signal="SIGINT")
    pid = os.popen("ps -aux | grep monitor.py | head -n3 | awk \'{print $2}\'").read()
    pids = pid.split("\n")
    print(pids[:-1])
    for pid in pids[1:-1]:
        try:
            os.kill(int(pid),signal.SIGINT)
        except:
            continue
    # cmd_list = ["/usr/bin/python3","/monitor/monitor.py","-l", str(label),"-i",str(interval),"-t",str(total_time)]
    # p = subprocess.Popen(cmd_list,stdout=sys.stdout)

def array_to_bytes(arr):
    np_bytes = BytesIO()
    np.save(np_bytes, arr, allow_pickle=True)
    return np_bytes.getvalue()

def print_fps(queue):
    if not queue.empty():
        current=queue.qsize()
        print("input fps: {}".format(current))
        while not queue.empty():
            queue.get_nowait() 

if __name__ == "__main__": 
    ctx = zmq.Context()
    socket = ctx.socket(zmq.PUB)
    socket.bind("tcp://*:1233")
    debug = False
    parser = argparse.ArgumentParser(description='Input process')
    parser.add_argument("-f", "--file", help="input video name", required=True)
    # parser.add_argument("-i", "--sleep_time", help="sleep time", required=True)
    parser.add_argument("-t", "--time", help="enbale / disable print time", required=True)
    parser.add_argument("-m", "--monitoring_period", help="data gather period", required=True)
    parser.add_argument("-r", "--ratio_config", help="config for change the sleep_time dynamically", required=True)
    args = parser.parse_args()

    prv = 0
    current = 0
    time_queue = multiprocessing.Queue()
    
    if int(args.time) == 1:
        timer = PeriodicTimer(1, print_fps,args=[time_queue])
        timer.start()

    input_video = args.file

    if not os.path.exists(input_video):
        print(input_video + " not exists")
        sys.exit(0)

    
    if not os.path.exists(args.ratio_config):
        print(args.ratio_config + " not exists")
        sys.exit(0)
    client = docker.from_env()
    sleep_ratio_list = []
    running_container = client.containers.list()
    monitor_container = None
    for con in running_container:
        if con.name ==  "vehicle_detection_and_tracking_pipeline_promethus_client_1":
            monitor_container = con
    print(monitor_container)
    with open(args.ratio_config,"r") as f:
        raw_data = f.readlines()
        for line in raw_data:
            data = line.strip().split()
            print(data)
            try:
                sleep_ratio_list.append((int(data[0]),int(data[1]),int(data[2])))
            except:
                print("input type of data in config is wrong")
                sys.exit(0)

    sleep_time = 1/sleep_ratio_list[0][0]
    deadline = sleep_ratio_list[0][1]
    run_monitor(client, monitor_container)
    sleep_ratio_list.pop(0)
    while(True):
        if debug: 
                images = [cv2.imread(file) for file in glob.glob('./test_images/*.jpg')]
                for image in images:
                        sent_img = array_to_bytes(image)
                        socket.send(sent_img)
        else:
            cap = cv2.VideoCapture(input_video)
            if (cap.isOpened()== False):
                print("Error opening video stream or file")

            while cap.isOpened():     
                try:
                    ret,frame = cap.read()
                    if ret == True:
                        deadline -= sleep_time
                        time.sleep(sleep_time)
                        if deadline <= 0:
                            # monitor_process.kill()
                            # monitor_process.wait()
                            sleep_time = 1/sleep_ratio_list[0][0]
                            deadline = sleep_ratio_list[0][1]
                            run_monitor(client, monitor_container)
                            sleep_ratio_list.pop(0)
                        sent_img = array_to_bytes(frame) 
                        socket.send(sent_img)
                        time_queue.put(1)

                    else:
                        break
                except KeyboardInterrupt:
                    sys.exit(0)
        
