#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

# Play rosbag
echo "[MiSelf] Starting playback"
echo "[MiSelf] DARKNET_ROS_BAG_FOLDER: "$DARKNET_ROS_BAG_FOLDER
rosbag play $DARKNET_ROS_BAG_FOLDER/2011_09_30_0027-10s.bag /cam00/image_raw:=camera/rgb/image_raw
echo "[MiSelf] Done with playback"

# Kill darknet
pkill roslaunch
pkill darknet_ros