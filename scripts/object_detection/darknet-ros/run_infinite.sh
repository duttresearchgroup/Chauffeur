#!/bin/bash

DIR=$HOME/workspace/Chauffeur/scripts/object_detection/darknet-ros
source $DIR/../../envs.sh

cd $DARKNET_ROS_BINARY_FOLDER
source ./setup.bash

while [ 1 ]
do
	DARKNET_ROS_LABELS_FOLDER=$DARKNET_ROS_LABELS_FOLDER \
	DARKNET_ROS_BAG_FOLDER=$DARKNET_ROS_BAG_FOLDER \
	roslaunch --wait  darknet_ros   darknet_ros_infinite.launch
done
