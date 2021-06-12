#!/bin/bash

DIR=$HOME/workspace/Chauffeur/scripts/structure_from_motion/open-mvg
source $DIR/../../envs.sh

rm -rf $OPEN_MVG_OUTPUT_FOLDER

cd $OPEN_MVG_BINARY_FOLDER
while [ 1 ]
do
python $OPEN_MVG_SCRIPT_NAME \
    $OPEN_MVG_DATA_FOLDER \
    $OPEN_MVG_OUTPUT_FOLDER \
    $OPEN_MVG_BINARY_FOLDER \
    $OPEN_MVG_WEIGHT_FOLDER
done
