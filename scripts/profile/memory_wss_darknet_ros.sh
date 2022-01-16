#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $DARKNET_ROS_MEMORY_OUTPUT_LOGS ] && > $DARKNET_ROS_MEMORY_OUTPUT_LOGS

sleep $WARM_UP_TIME

cd $WSS_FOLDER

./$WSS_BINARY_NAME -s 1 $(ps -aux | grep __name:=darknet_ros | awk '{print $2}' | head -n 1) 0.1 > $DARKNET_ROS_MEMORY_OUTPUT_LOGS