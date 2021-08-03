#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $JETSON_LANE_DETECTION_BINARY_FOLDER && ./$JETSON_LANE_DETECTION_BINARY_NAME $JETSON_LANE_DETECTION_DATA_FOLDER/detect.cfg
