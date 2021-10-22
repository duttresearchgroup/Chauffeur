#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [local/cross]"
fi

if [[ $1 == "local" ]];then
  echo "Local run"
fi

if [[ $1 == "cross" ]];then
  cd $ORBSLAM_BINARY_FOLDER
  
  ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:${PWD}/ORB_SLAM3 \
    rosrun \
    ORB_SLAM3 \
    Mono \
    Vocabulary/ORBvoc.txt \
    Examples/Monocular/KITTI03.yaml \
    2>&1 | tee os3_ros.log &

  # Wait for 5 seconds
  sleep 5

  # Check if vocabulary is loaded
  ( tail -f -n0 os3_ros.log & ) | grep -q "Vocabulary loaded!"

  rosbag play $ORBSLAM_DATA_FOLDER/2011_09_30_0027-10s.bag /cam00/image_raw:=/camera/image_raw

  pkill Mono
fi

wait
