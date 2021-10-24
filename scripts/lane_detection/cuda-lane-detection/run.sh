#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

$DIR/../../../applications/lane_detection/cuda-lane-detection/build/./cuda-lane-detection \
$DIR/../../../data/test-video.mp4 \
$DIR/../../../data/result-video.avi \
--cuda
