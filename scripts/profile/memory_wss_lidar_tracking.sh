#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $LIDAR_TRACKING_MEMORY_OUTPUT_LOGS ] && > $LIDAR_TRACKING_MEMORY_OUTPUT_LOGS

sleep $WARM_UP_TIME

cd $WSS_FOLDER

./$WSS_BINARY_NAME -s 1 $(ps -aux | grep multi_object_tracking_lidar | awk '{print $2}' | head -n 1) 0.1 > $LIDAR_TRACKING_MEMORY_OUTPUT_LOGS
