#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $CUDA_LANE_DETECTION_BINARY_FOLDER
./$CUDA_LANE_DETECTION_BINARY_NAME \
    $CUDA_LANE_DETECTION_DATA_FOLDER/test-video.mp4 \
    $CUDA_LANE_DETECTION_DATA_FOLDER/result-video.avi \
    --cuda