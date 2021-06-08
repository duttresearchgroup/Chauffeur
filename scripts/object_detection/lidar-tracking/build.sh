#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi


if [[ $1 == "tx2" ]]; then
	mkdir -p ~/catkin_ws/src
	cd ~/catkin_ws/src
	cp -r $R_SRC_ROOT/applications/object_detection/lidar-tracking ./
	cd ~/catkin_ws
	catkin_make
fi