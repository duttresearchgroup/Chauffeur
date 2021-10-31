#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $CUDA_LANE_DETECTION_MEMORY_OUTPUT_LOGS ] && > $CUDA_LANE_DETECTION_MEMORY_OUTPUT_LOGS

sleep 3
cd $WSS_FOLDER
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep result-video.avi | awk '{print $2}' | head -n 1) 0.1 > $CUDA_LANE_DETECTION_MEMORY_OUTPUT_LOGS
