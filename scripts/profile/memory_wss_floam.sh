#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $FLOAM_MEMORY_OUTPUT_LOGS_1 ] && > $FLOAM_MEMORY_OUTPUT_LOGS_1
[ -f $FLOAM_MEMORY_OUTPUT_LOGS_2 ] && > $FLOAM_MEMORY_OUTPUT_LOGS_2

sleep 3
cd $WSS_FOLDER

./$WSS_BINARY_NAME -s 1 $(ps -aux | grep __name:=floam_odom_estimation_node | awk '{print $2}' | head -n 1) 0.1 > $FLOAM_MEMORY_OUTPUT_LOGS_1 &
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep __name:=floam_laser_processing_node | awk '{print $2}' | head -n 1) 0.1 > $FLOAM_MEMORY_OUTPUT_LOGS_2 