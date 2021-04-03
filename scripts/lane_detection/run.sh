#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

cd $LANE_DETECTION_BINARY_FOLDER && ./$LANE_DETECTION_BINARY_NAME $LANE_DETECTION_DATA_FOLDER/detect.cfg
