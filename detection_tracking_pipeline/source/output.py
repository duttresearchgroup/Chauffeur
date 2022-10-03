import zmq
import sys
import os
from io import BytesIO
import numpy as np
from moviepy.editor import *
import cv2
import argparse
import time
import glob
from custom_timer import *
import multiprocessing

def bytes_to_array(b):
    load_bytes = BytesIO(b)
    return np.load(load_bytes, allow_pickle=True)

def write_video(img):
    return img

def print_fps(queue):
    if not queue.empty():
        current=queue.qsize()
        print("output fps: {}".format(current))
        while not queue.empty():
            queue.get_nowait() 

if __name__ == "__main__":
    ctx = zmq.Context()
    socket = ctx.socket(zmq.SUB)
    socket.connect("tcp://127.0.0.1:1235")
    socket.subscribe("")  # Subscribe to all topics

    print("Starting output loop ...")
    parser = argparse.ArgumentParser(description='Output process')
    parser.add_argument("-d", "--dir", help="output directory of detection and tracking results", required=True)
    parser.add_argument("-w", "--write", help="whether wrtie detection results to ouput directory", action="store_true")
    args = parser.parse_args()
    prv = 0
    current = 0
    time_queue = multiprocessing.Queue()
    timer = PeriodicTimer(1,print_fps,args=[time_queue])
    timer.start()
    
    write_file = False

    if os.path.isdir(args.dir):
        pass
    else:
        os.mkdir(args.dir) 

    os.chdir(args.dir)
    
    frame_count = 0

    if args.write:
        write_file = True

    while True:
        try:
            img = bytes_to_array(socket.recv())
            if img.any():
                if write_file:
                    frame_count+=1
                    cv2.imwrite(str(frame_count) + ".png", img)
                
                time_queue.put(1)
        except KeyboardInterrupt:
            sys.exit(0)
        

       
