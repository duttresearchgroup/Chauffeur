#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $DARKNET_ROS_BINARY_FOLDER
cat ./setup.bash
source ./setup.bash

[ -f $DARKNET_ROS_OUTPUT_LOGS ] && > $DARKNET_ROS_OUTPUT_LOGS

while [ 1 ]
do
	DARKNET_ROS_LABELS_FOLDER=$DARKNET_ROS_LABELS_FOLDER \
	DARKNET_ROS_BAG_FOLDER=$DARKNET_ROS_BAG_FOLDER \
	roslaunch darknet_ros darknet_ros.launch 2> /dev/null 
done 1> $DARKNET_ROS_OUTPUT_LOGS 