#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $HYBRID_ASTAR_BINARY_FOLDER
source ./devel/setup.bash

[ -f $HYBRID_ASTAR_TIMING_LOGS ] && > $HYBRID_ASTAR_TIMING_LOGS

cd $HYBRID_ASTAR_RUNNING_SCRIPT_FOLDER

while [ 1 ]
do
    time (
        rosrun map_server map_server $HYBRID_ASTAR_DATA_FOLDER/map.yaml & 
        rosrun hybrid_astar tf_broadcaster &
        rosrun hybrid_astar hybrid_astar 1> /dev/null
        pkill tf_broadcaster 
        pkill map_server 
        wait 2> /dev/null
    )
    
done 2>> $HYBRID_ASTAR_TIMING_LOGS