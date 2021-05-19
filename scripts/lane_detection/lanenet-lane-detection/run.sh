#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [image/video]"
	exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

cd $LANENET_LANE_DETECTION_ROOT_FOLDER
PYTHONPATH=$PYTHONPATH:$LANENET_LANE_DETECTION_ROOT_FOLDER

# ************* For testing with a single image *************
if [[ $1 == "image" ]];then
    python3.6 $LANENET_LANE_DETECTION_ROOT_FOLDER/tools/test_lanenet.py \
        --weights_path $LANENET_LANE_DETECTION_MODEL_FOLDER/model/tusimple_lanenet/tusimple_lanenet.ckpt \
        --image_path $LANENET_LANE_DETECTION_ROOT_FOLDER/data/tusimple_test_image/0.jpg
fi
# ***********************************************************

# ************* For testing with a image sequence  *************
if [[ $1 == "video" ]];then
    python3.6 tools/evaluate_lanenet_on_tusimple.py \
        --image_dir $LANENET_LANE_DETECTION_DATA_FOLDER/TUSIMPLE_DATASET/test_set/clips \
        --weights_path $LANENET_LANE_DETECTION_MODEL_FOLDER/model/tusimple_lanenet/tusimple_lanenet.ckpt \
        --save_dir $LANENET_LANE_DETECTION_DATA_FOLDER/TUSIMPLE_DATASET/test_set/test_output
fi
# ***********************************************************