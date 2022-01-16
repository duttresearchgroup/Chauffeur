#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_1 ] && > $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_1
[ -f $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_2 ] && > $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_2
[ -f $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_3 ] && > $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_3

sleep $WARM_UP_TIME

cd $WSS_FOLDER

while [ 1 ]
do
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep map_server | awk '{print $2}' | head -n 1) 0.1 >> $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_1 &
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep tf_broadcaster | awk '{print $2}' | head -n 1) 0.1 >> $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_2 & 
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep hybrid_astar/hybrid_astar | awk '{print $2}' | head -n 1) 0.1 >> $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_3
done