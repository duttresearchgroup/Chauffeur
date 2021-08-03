#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

# ROS_PROCESSES=$(ps aux | grep ros | wc -l)
# if [[ ${ROS_PROCESSES} -gt 5 ]] ; then
#     echo "Please make sure there is no zombie ROS launchers running..."
#     exit 1
# else
#     echo "Launching Darknet ..."
# fi
# Kill previously running instances
pkill roslaunch
pkill darknet_ros

cd $DARKNET_ROS_BINARY_FOLDER
source ./setup.bash
DARKNET_ROS_LABELS_FOLDER=$DARKNET_ROS_LABELS_FOLDER \
    DARKNET_ROS_BAG_FOLDER=$DARKNET_ROS_BAG_FOLDER \
    roslaunch \
    darknet_ros \
    darknet_ros.launch \
    2>&1 | tee darknet_ros.log &

# Wait for 5 seconds
sleep 5

# Check if weights are loaded
( tail -f -n0 darknet_ros.log & ) | grep -q "Loading weights from"
exit 0