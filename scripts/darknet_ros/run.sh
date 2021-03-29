#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

$DIR/01_init.sh $1
echo "[MiSelf] darknet_ros init complete"
DARKNET_ROS_BAG_FOLDER=$DARKNET_ROS_BAG_FOLDER $DIR/02_play.sh