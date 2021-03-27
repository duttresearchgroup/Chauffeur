#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1


cd $FLOAM_BINARY_FOLDER/launch

roslaunch floam floam.launch


