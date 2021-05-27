#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [imagenet/detectnet/segnet] [image/video]"
	exit 1
fi

if [[ $1 == "imagenet" && $2 == video ]];then
	cd $JETSON_INFERENCE_BINARY_FOLDER
	./$JETSON_INFERENCE_BINARY_NAME_IMAGENET --headless --input-codec=h264 \
    	$CUDA_LANE_DETECTION_DATA_FOLDER/test-video.mp4 \
    	$JETSON_INFERENCE_DATA_FOLDER/images/test/output_video_imagenet.mp4
fi

if [[ $1 == "imagenet" && $2 == image ]];then

        cd $JETSON_INFERENCE_BINARY_FOLDER
        ./$JETSON_INFERENCE_BINARY_NAME_IMAGENET \
        $JETSON_INFERENCE_DATA_FOLDER/images/orange_0.jpg \
        $JETSON_INFERENCE_DATA_FOLDER/images/test/output_imagenet.jpg
fi

if [[ $1 == "detectnet" && $2 == video ]];then

        cd $JETSON_INFERENCE_BINARY_FOLDER
        ./$JETSON_INFERENCE_BINARY_NAME_DETECTNET --headless --input-codec=h264 \
        $CUDA_LANE_DETECTION_DATA_FOLDER/test-video.mp4 \
        $JETSON_INFERENCE_DATA_FOLDER/images/test/output_video_detectnet.mp4
fi

if [[ $1 == "detectnet" && $2 == image ]];then

        cd $JETSON_INFERENCE_BINARY_FOLDER
        ./$JETSON_INFERENCE_BINARY_NAME_DETECTNET \
        $JETSON_INFERENCE_DATA_FOLDER/images/peds_1.jpg \
        $JETSON_INFERENCE_DATA_FOLDER/images/test/output_detectnet.jpg
fi


if [[ $1 == "segnet" && $2 == video ]];then

        cd $JETSON_INFERENCE_BINARY_FOLDER
        ./$JETSON_INFERENCE_BINARY_NAME_SEGNET  --headless --input-codec=h264 \
        $CUDA_LANE_DETECTION_DATA_FOLDER/test-video.mp4 \
        $JETSON_INFERENCE_DATA_FOLDER/images/test/output_video_segnet.mp4
fi

if [[ $1 == "segnet" && $2 == image ]];then

        cd $JETSON_INFERENCE_BINARY_FOLDER
        ./$JETSON_INFERENCE_BINARY_NAME_DETECTNET \
        $JETSON_INFERENCE_DATA_FOLDER/images/city_0.jpg \
        $JETSON_INFERENCE_DATA_FOLDER/images/test/output_segnet.jpg
fi

