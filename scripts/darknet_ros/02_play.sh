#!/bin/bash

# Play rosbag
echo "[MiSelf] Starting playback"
rosbag play $DARKNET_ROS_BAG_FOLDER/2011_09_30_0027-10s.bag /cam00/image_raw:=camera/rgb/image_raw
echo "[MiSelf] Done with playback"

# Kill darknet
pkill roslaunch
pkill darknet_ros