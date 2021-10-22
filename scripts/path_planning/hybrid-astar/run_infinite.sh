#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $HYBRID_ASTAR_BINARY_FOLDER
source ./devel/setup.bash

[ -f $HYBRID_ASTAR_TIMING_LOGS ] && > $HYBRID_ASTAR_TIMING_LOGS

cd $HYBRID_ASTAR_RUNNING_SCRIPT_FOLDER

while [ 1 ] 
do
    time ./run.sh "local"
    
done 2>> $HYBRID_ASTAR_TIMING_LOGS