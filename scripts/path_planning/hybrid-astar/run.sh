#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [local/cross]"
fi

if [[ $1 == "local" ]];then
  cd $HYBRID_ASTAR_BINARY_FOLDER
  source ./devel/setup.bash

  # run ros nodes individually so we can kill them when the planner exits
  rosrun map_server map_server $HYBRID_ASTAR_DATA_FOLDER/map.yaml &
  rosrun hybrid_astar tf_broadcaster &
  rosrun hybrid_astar hybrid_astar 1> /dev/null
  pkill tf_broadcaster 
  pkill map_server

fi 2> /dev/null

if [[ $1 == "cross" ]];then
  cd $HYBRID_ASTAR_BINARY_FOLDER
  source ./setup.bash

  # run ros nodes individually so we can kill them when the planner exits
  rosrun map_server map_server $HYBRID_ASTAR_DATA_FOLDER/map.yaml &
  rosrun hybrid_astar tf_broadcaster &
  rosrun hybrid_astar hybrid_astar
  pkill tf_broadcaster
  pkill map_server
fi 

wait 2> /dev/null
