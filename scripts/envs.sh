# Chimera

if [[ $1 == 'cross' ]]; then
    export R_USER=deep
    export R_PORT=-p22
    export R_HOST=chimera.ics.uci.edu
    export R_SRC_ROOT=/home/deep/workspace/miself

    # Drive PX2
    # export R_USER=nvidia
    # export R_PORT=-p22222
    # export R_HOST=203.246.112.155
    # export R_SRC_ROOT=/home/nvidia/deep/miself

    # export R_USER=leming
    # export R_PORT=-p22
    # export R_HOST=hydra.ics.uci.edu
    # export R_SRC_ROOT=/home/leming/deep/miself
else
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    export R_SRC_ROOT=$DIR/..
fi

# Lane Detection
if [[ $1 == 'cross' ]]; then
    LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/bin
    LANE_DETECTION_BINARY_NAME=lane-detect
    LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane-detect
else
    LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/lane_detection$/bin
    LANE_DETECTION_BINARY_NAME=detect
    LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/applications/lane_detection/test
fi

# Kalman Filter
if [[ $1 == 'cross' ]]; then
    KALMAN_FILTER_BINARY_FOLDER=$R_SRC_ROOT/bin
    KALMAN_FILTER_BINARY_NAME=ExtendedKF
    KALMAN_FILTER_DATA_FOLDER=$R_SRC_ROOT/data/kalman-filter
else
    KALMAN_FILTER_BINARY_FOLDER=$R_SRC_ROOT/applications/Kalman-Filter/build
    KALMAN_FILTER_BINARY_NAME=ExtendedKF
    KALMAN_FILTER_DATA_FOLDER=$R_SRC_ROOT/applications/Kalman-Filter/data
fi

# Jetson Inference
if [[ $1 == 'cross' ]]; then
    JETSON_INFERENCE_BINARY_FOLDER=$R_SRC_ROOT/bin/jetson-inference/bin
    JETSON_INFERENCE_BINARY_NAME=imagenet
    JETSON_INFERENCE_DATA_FOLDER=$R_SRC_ROOT/data/jetson-inference
else
    JETSON_INFERENCE_BINARY_FOLDER=$R_SRC_ROOT/applications/jetson-inference/build/aarch64/bin
    JETSON_INFERENCE_BINARY_NAME=imagenet
    JETSON_INFERENCE_DATA_FOLDER=$R_SRC_ROOT/applications/jetson-inference/build/aarch64/bin
fi

# Cuda Lane Detection
if [[ $1 == 'cross' ]]; then
    CUDA_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/bin/
    CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
    CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/cuda-lane-detection
else
    CUDA_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection/build
    CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
    CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection
fi