#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $LT_MEMORY_OUTPUT_LOGS ] && > $LT_MEMORY_OUTPUT_LOGS

sleep 3
cd $WSS_FOLDER
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep multi_object_tracking_lidar | awk '{print $2}' | head -n 1) 0.1 > $LT_MEMORY_OUTPUT_LOGS
