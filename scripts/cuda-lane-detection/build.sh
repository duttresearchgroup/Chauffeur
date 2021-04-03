#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
fi

if [[ $1 == "px2" ]];then
	cd $CUDA_LANE_DETECTION_BINARY_FOLDER
	nvcc -gencode arch=compute_61,code=sm_61 -I/usr/local/include/opencv2 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -o cuda-lane-detection
fi


if [[ $1 == "tx2" ]];then	
	cd $CUDA_LANE_DETECTION_BINARY_FOLDER
	nvcc -gencode arch=compute_62,code=sm_62 -I/usr/local/include/opencv2 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -o cuda-lane-detection

fi
