#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $JETSON_INFERENCE_BINARY_FOLDER
./$JETSON_INFERENCE_BINARY_NAME --headless --input-codec=h264 \
    $CUDA_LANE_DETECTION_BINARY_FOLDER/test-video.mp4 \
    $JETSON_INFERENCE_DATA_FOLDER/images/test/output_video_0.mp4
