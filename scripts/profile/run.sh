#!/bin/bash

source /home/nvidia/.bashrc
source /home/nvidia/Workspace/Chauffeur/applications/object_tracking/lidar-tracking/build/devel/setup.bash
/home/nvidia/Workspace/Chauffeur/applications/object_tracking/lidar-tracking/build/devel/lib/multi_object_tracking_lidar/kf_tracker &
PID=$#
sleep 10

killall -9 kf_tracker
