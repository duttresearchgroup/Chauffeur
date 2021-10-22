#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

rm -rf $OPEN_MVG_OUTPUT_FOLDER

cd $OPEN_MVG_BINARY_FOLDER
for i in 1 
do
python $OPEN_MVG_SCRIPT_NAME \
    $OPEN_MVG_DATA_FOLDER \
    $OPEN_MVG_OUTPUT_FOLDER \
    $OPEN_MVG_BINARY_FOLDER \
    $OPEN_MVG_WEIGHT_FOLDER 
done
