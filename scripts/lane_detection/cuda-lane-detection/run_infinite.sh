#!/bin/bash

DIR=/home/deep/workspace/Chauffeur/
source $DIR/scripts/envs.sh


while [ 1 ]
do
    $DIR/applications/lane_detection/cuda-lane-detection/build/./cuda-lane-detection \
    $DIR/data/test-video.mp4 \
    $DIR/data/result-video.avi \
    --cuda
done
