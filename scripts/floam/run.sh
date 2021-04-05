#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

cd $FLOAM_BINARY_FOLDER
source ./devel/setup.bash

# (re)start roscore
pkill rosmaster
roscore &

roslaunch --wait floam floam.launch &
sleep 5
rosbag play --clock $FLOAM_DATA_FOLDER/2011_09_30_0027-10s.bag
pkill roslaunch
pkill floam 
