#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

cd $HYBRID_ASTAR_BINARY_FOLDER
source ./setup.bash

# run ros nodes individually so we can kill them when the planner exits
rosrun map_server map_server $HYBRID_ASTAR_DATA_FOLDER/map.yaml &
rosrun hybrid_astar tf_broadcaster &
rosrun hybrid_astar hybrid_astar
pkill tf_broadcaster
pkill map_server
wait