#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

# Play rosbag
echo "[Chauffeur] Starting playback"
echo "[Chauffeur] DARKNET_ROS_BAG_FOLDER: "$DARKNET_ROS_BAG_FOLDER
rosbag play $DARKNET_ROS_BAG_FOLDER/2011_09_30_0027-10s.bag /cam00/image_raw:=camera/rgb/image_raw
echo "[Chauffeur] Done with playback"

# Kill darknet
pkill roslaunch
pkill darknet_ros