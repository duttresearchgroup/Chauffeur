#/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1





### The importation is not working for now, need to fix
export PYTHONPATH="${PYTHONPATH}:$LANENET_LANE_DETECTION_BINARY_FOLDER/lanenet-lane-detection/lanenet_model/" 
echo $PYTHONPATH
echo "This file is not working. The importation is not working and it won't fine the lanenet_model for now, need to fix"


LD_PRELOAD=$LANENET_LANE_DETECTION_PRELOAD_DIR python3.6 $LANENET_LANE_DETECTION_BINARY_FOLDER/lanenet-lane-detection/tools/test_lanenet.py --weights_path $LANENET_LANE_DETECTION_BINARY_FOLDER/model/tusimple_lanenet/tusimple_lanenet.ckpt --image_path $LANENET_LANE_DETECTION_DATA_FOLDER/0.jpg
