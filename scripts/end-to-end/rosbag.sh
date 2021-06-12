#!/bin/bash

ROSBAG_PATH=$1/data/2011_09_30_0027-10s.bag

# for darknet_ros -> camera/rgb/image_raw
# for lidar-tracking -> filtered_cloud

while [ 1 ]
do
rosbag play -l $ROSBAG_PATH /cam00/image_raw:=/camera/rgb/image_raw /velodyne_points:=/filtered_cloud /cam01/image_raw:=/camera/image_raw
done
