#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $FLOAM_BINARY_FOLDER
source ./devel/setup.bash
roslaunch floam floam.launch
