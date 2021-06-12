#!/bin/bash

DIR=$1/scripts/object_detection/darknet-ros
source $DIR/../../envs.sh

cd $DIR
source /opt/ros/melodic/setup.bash
source install/setup.bash

while [ 1 ]
do
	roslaunch     darknet_ros     darknet_ros.launch
done
