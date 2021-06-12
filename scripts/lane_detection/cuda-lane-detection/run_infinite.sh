#!/bin/bash

DIR=$1
source $DIR/../../envs.sh

cd $CUDA_LANE_DETECTION_ROOT_FOLDER/build

while [ 1 ]
do
./$CUDA_LANE_DETECTION_BINARY_NAME \
    $CUDA_LANE_DETECTION_DATA_FOLDER/test-video.mp4 \
    $CUDA_LANE_DETECTION_DATA_FOLDER/result-video.avi \
    --cuda
done
