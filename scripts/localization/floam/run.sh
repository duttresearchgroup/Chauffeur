#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [local/cross]"
fi

if [[ $1 == "local" ]];then
  cd $FLOAM_BINARY_FOLDER
  source ./devel/setup.bash

  # (re)start roscore
  pkill rosmaster
  roscore &

  roslaunch --wait floam floam_chauffeur.launch &
  sleep 5
  rosbag play --clock $FLOAM_DATA_FOLDER/2011_09_30_0027-10s.bag
  pkill roslaunch
  pkill floam
fi

if [[ $1 == "cross" ]];then
  cd $FLOAM_BINARY_FOLDER
  source ./install/setup.bash

  # (re)start roscore
  pkill rosmaster
  roscore &

  roslaunch --wait floam floam_chauffeur.launch &
  sleep 5
  rosbag play --clock $FLOAM_DATA_FOLDER/2011_09_30_0027-10s.bag
  pkill roslaunch
  pkill floam
fi