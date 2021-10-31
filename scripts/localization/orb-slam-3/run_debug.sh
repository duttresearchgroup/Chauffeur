#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/orb-slam-3/Examples/ROS/ORB_SLAM3/build;
source /opt/ros/melodic/setup.bash
source devel/setup.bash
source $DIR/../../envs.sh

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

# rosbag play -l $ORBSLAM_DATA_FOLDER/2011_09_30_0027-10s.bag /cam00/image_raw:=/camera/image_raw 1> /dev/null

# pkill Mono
wait

