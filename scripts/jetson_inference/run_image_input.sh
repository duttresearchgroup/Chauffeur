#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1


cd $JETSON_INFERENCE_BINARY_FOLDER


./$JETSON_INFERENCE_BINARY_NAME \
    $JETSON_INFERENCE_DATA_FOLDER/images/orange_0.jpg \
    $JETSON_INFERENCE_DATA_FOLDER/images/test/output_0.jpg
