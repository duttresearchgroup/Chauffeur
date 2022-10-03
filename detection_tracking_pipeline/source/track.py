import zmq
import time
import numpy as np
from io import BytesIO
import helpers 
from collections import deque
from sklearn.utils.linear_assignment_ import linear_assignment
import tracker
import cv2
import sys
import argparse

def assign_detections_to_trackers(trackers, detections, iou_thrd):
    
    """
        From current list of trackers and new detections, output matched detections,
        unmatchted trackers, unmatched detections.
    """    
    
    IOU_mat= np.zeros((len(trackers),len(detections)),dtype=np.float32)
    for t,trk in enumerate(trackers):
        for d,det in enumerate(detections):
            IOU_mat[t,d] = helpers.box_iou2(trk,det) 
    
    """ 
        Produces matches       
        Solve the maximizing the sum of IOU assignment problem using the
        Hungarian algorithm (also known as Munkres algorithm)
    """
    
    matched_idx = linear_assignment(-IOU_mat)        

    unmatched_trackers, unmatched_detections = [], []
    for t,trk in enumerate(trackers):
        if(t not in matched_idx[:,0]):
            unmatched_trackers.append(t)

    for d, det in enumerate(detections):
        if(d not in matched_idx[:,1]):
            unmatched_detections.append(d)

    matches = []
   
    """
        For creating trackers we consider any detection with an 
        overlap less than iou_thrd to signifiy the existence of 
        an untracked object
    """
    
    for m in matched_idx:
        if(IOU_mat[m[0],m[1]]<iou_thrd):
            unmatched_trackers.append(m[0])
            unmatched_detections.append(m[1])
        else:
            matches.append(m.reshape(1,2))
    
    if(len(matches)==0):
        matches = np.empty((0,2),dtype=int)
    else:
        matches = np.concatenate(matches,axis=0)
    
    return matches, np.array(unmatched_detections), np.array(unmatched_trackers)       

def tracking(img, z_box):
    global frame_count
    global tracker_list
    global max_age
    global min_hits
    global track_id_list
    global debug
    global verbose
    global show_time

    start = time.time()
   
    x_box =[]
    
    if len(tracker_list) > 0:
        for trk in tracker_list:
            x_box.append(trk.box)
    
    matched, unmatched_dets, unmatched_trks \
        = assign_detections_to_trackers(x_box, z_box, iou_thrd = 0.3)  
    
    if debug:
         print('Detection: ', z_box)
         print('x_box: ', x_box)
         print('matched:', matched)
         print('unmatched_det:', unmatched_dets)
         print('unmatched_trks:', unmatched_trks)
     
    if matched.size >0:     # Deal with matched detections
        for trk_idx, det_idx in matched:
            z = z_box[det_idx]
            z = np.expand_dims(z, axis=0).T
            tmp_trk= tracker_list[trk_idx]
            tmp_trk.kalman_filter(z)
            xx = tmp_trk.x_state.T[0].tolist()
            xx =[xx[0], xx[2], xx[4], xx[6]]
            x_box[trk_idx] = xx
            tmp_trk.box =xx
            tmp_trk.hits += 1
            tmp_trk.no_losses = 0
    
        
    if len(unmatched_dets)>0:   # Deal with matched detections  
        for idx in unmatched_dets:
            z = z_box[idx]
            z = np.expand_dims(z, axis=0).T
            tmp_trk = tracker.Tracker() 
            x = np.array([[z[0], 0, z[1], 0, z[2], 0, z[3], 0]]).T
            tmp_trk.x_state = x
            tmp_trk.predict_only()
            xx = tmp_trk.x_state
            xx = xx.T[0].tolist()
            xx =[xx[0], xx[2], xx[4], xx[6]]
            tmp_trk.box = xx
            tmp_trk.id = track_id_list.popleft() 
            tracker_list.append(tmp_trk)
            x_box.append(xx)
    
    
    if len(unmatched_trks)>0:   # Deal with unmatched tracks    
        for trk_idx in unmatched_trks:
            tmp_trk = tracker_list[trk_idx]
            tmp_trk.no_losses += 1
            tmp_trk.predict_only()
            xx = tmp_trk.x_state
            xx = xx.T[0].tolist()
            xx =[xx[0], xx[2], xx[4], xx[6]]
            tmp_trk.box =xx
            x_box[trk_idx] = xx
                   
       
    
    good_tracker_list =[]   # The list of tracks to be annotated  
    
    for trk in tracker_list:
        if ((trk.hits >= min_hits) and (trk.no_losses <=max_age)):
                good_tracker_list.append(trk)
                x_cv2 = trk.box
                if debug:
                    print('updated box: ', x_cv2)
                img = helpers.draw_box_label(img, x_cv2) 
    

    deleted_tracks = filter(lambda x: x.no_losses >max_age, tracker_list)   # Book keeping
    
    for trk in deleted_tracks:
            track_id_list.append(trk.id)
    
    tracker_list = [x for x in tracker_list if x.no_losses<=max_age]
    
    if debug:
        print('Ending tracker_list: ',len(tracker_list))
        print('Ending good tracker_list: ',len(good_tracker_list))
        cv2.imshow('Tracking result: ' + str(frame_count), img)
        cv2.waitKey(0) 
        cv2.destroyAllWindows() 
    
    end = time.time()

    if show_time:
        print("Tracking time:" + str(round(end-start,5)) + " seconds")
    
    sent_img = array_to_bytes(img)
    socket2.send(sent_img)
    frame_count +=1
     
    if verbose:
        print("Finish "+ str(frame_count) + " frames")

def bytes_to_array(b):
    load_bytes = BytesIO(b)
    return np.load(load_bytes, allow_pickle=True)

def array_to_bytes(arr):
    np_bytes = BytesIO()
    np.save(np_bytes, arr, allow_pickle=True)
    return np_bytes.getvalue()

if __name__ == "__main__":
    
    ctx = zmq.Context()
    socket1 = ctx.socket(zmq.SUB)
    socket1.connect("tcp://127.0.0.1:1234")
    socket1.subscribe("")  # Subscribe to all topics

    socket2 = ctx.socket(zmq.PUB)
    socket2.connect("tcp://127.0.0.1:1235")
    socket2.bind("tcp://*:1235")

    debug = False
    verbose = False
    show_time = False
    frame_count = 0 
    tracker_list =[] 
    track_id_list= deque(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K']) 

    max_age = 4 # Num.of consecutive unmatched detection before a track is deleted.
    min_hits = 1  # Num. of consecutive matches needed to establish a track

    parser = argparse.ArgumentParser(description='Tracking process')
    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", help="enable debug mode", action="store_true")
    parser.add_argument("--verbose", help="increase output verbosity", action="store_true")
    parser.add_argument("--time", help="show processing time", action="store_true")
    
    args = parser.parse_args()

    if args.debug:
        debug = True

    if args.verbose:
        verbose = True
    
    if args.time:
        show_time = True 
    else:
        show_time = False


    print("Starting tracking loop ...")
    print("Press Ctrl+c to end the tracking")
    
    while True:
        try:
            msg = socket1.recv_multipart()
            img = bytes_to_array(msg[0])
            z_box = bytes_to_array(msg[1]).tolist()
            tracking(img, z_box)

        except KeyboardInterrupt:
            sys.exit(0)
        
