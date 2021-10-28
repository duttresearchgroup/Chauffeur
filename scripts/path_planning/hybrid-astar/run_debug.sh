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
    
    if [ $? == 0 ]
    then
        echo "Hybird a* is running"
    else
        echo "Hybird a* is is not running, please check the running scripts"
    fi
    
done 2>> $HYBRID_ASTAR_TIMING_LOGS