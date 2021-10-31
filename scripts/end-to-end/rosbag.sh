#!/bin/bash

ROSBAG_PATH=/workspace/data/2011_09_30_0027-10s.bag

# for darknet_ros -> camera/rgb/image_raw
# for lidar-tracking -> filtered_cloud
source /opt/ros/melodic/setup.bash


rosbag play -l $ROSBAG_PATH /cam00/image_raw:=/camera/rgb/image_raw /velodyne_points:=/filtered_cloud /cam01/image_raw:=/camera/image_raw /cam00/image_raw:=/camera/image_raw &

