#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $OPEN_MVG_BINARY_FOLDER
python $OPEN_MVG_SCRIPT_NAME $OPEN_MVG_DATA_FOLDER $OPEN_MVG_OUTPUT_FOLDER
