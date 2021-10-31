#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $ORBSLAM_MEMORY_OUTPUT_LOGS ] && > $ORBSLAM_MEMORY_OUTPUT_LOGS

sleep 3
cd $WSS_FOLDER
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep ORB_SLAM3/Mono | awk '{print $2}' | head -n 1) 0.1 > $ORBSLAM_MEMORY_OUTPUT_LOGS
