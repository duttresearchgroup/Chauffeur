import zmq
import numpy as np
import glob
import time
import cv2
import os
from moviepy.editor import VideoFileClip
import helpers 
import detector
from io import BytesIO
import sys
import argparse

def array_to_bytes(arr):
    np_bytes = BytesIO()
    np.save(np_bytes, arr, allow_pickle=True)
    return np_bytes.getvalue()

def bytes_to_array(b):
    load_bytes = BytesIO(b)
    return np.load(load_bytes, allow_pickle=True)
    
def detect(img):
    '''
    Pipeline function for detection and send the result to tracking
    '''
    global socket
    global ctx
    global frame_count
    global debug
    global det
    global show_time

    start = time.time()

    img_dim = (img.shape[1], img.shape[0])
    z_box = det.get_localization(img) # Measurement
    
    if debug:
       print('Frame:', frame_count)
       
    x_box =[]

    if debug: 
        for i in range(len(z_box)):
            img1= helpers.draw_box_label(img, z_box[i], box_color=(255, 0, 0))
            cv2.imshow('Detect result: ' + str(frame_count), img1)
            cv2.waitKey(1000) 
            cv2.destroyAllWindows() 
    
    end = time.time()
    
    if show_time:
        print("Detect time:" + str(end-start) + " seconds")
    
    sent_img = array_to_bytes(img)
    sent_z_box = array_to_bytes(np.asarray(z_box))
    socket1.send_multipart([sent_img, sent_z_box])
    frame_count+=1

if __name__ == "__main__":  
    
    debug = False
    frame_count = 0
    det = None
    ctx = zmq.Context()
    socket1 = ctx.socket(zmq.PUB)
    socket1.bind("tcp://*:1234")

    socket2 = ctx.socket(zmq.SUB)
    socket2.connect("tcp://127.0.0.1:1233")
    socket2.subscribe("")  # Subscribe to all topics

    show_time = False

    parser = argparse.ArgumentParser(description='Detection process')
    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", help="enable debug mode", action="store_true")
    parser.add_argument("--verbose", help="increase output verbosity", action="store_true")  
    parser.add_argument("--time", help="show processing time", action="store_true")
    args = parser.parse_args()
    
    if args.debug:
        debug = True
    
    if args.time:
        show_time = True 

    if det == None:
        print("Initialize detector...")
        det = detector.CarDetector()
        warm_up_image = cv2.imread("./test_images/frame001.jpg")
        det.get_localization(warm_up_image)
        if args.verbose:
            det.verbose = True
    
    while True:
        try:
            image = bytes_to_array(socket2.recv())
            detect(image)
        except KeyboardInterrupt:
                sys.exit(0)
