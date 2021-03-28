#/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $DARKNET_ROS_BINARY_FOLDER
catkin build darknet_ros --no-deps --verbose --catkin-make-args run_tests
