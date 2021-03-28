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
    CUDA_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection
    CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
    CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection
fi

# OpenMVG
if [[ $1 == 'cross' ]]; then
    OPEN_MVG_BINARY_FOLDER=$R_SRC_ROOT/bin/openMVG
    OPEN_MVG_SCRIPT_NAME=SfM_SequentialPipeline.py
    OPEN_MVG_DATA_FOLDER=$R_SRC_ROOT/data/openMVG/Image_dataset/360_dataset/360_Flat/images
    OPEN_MVG_WEIGHT_FOLDER=$R_SRC_ROOT/data/openMVG
    OPEN_MVG_OUTPUT_FOLDER=$R_SRC_ROOT/output/openMVG
else
    OPEN_MVG_BINARY_FOLDER=$R_SRC_ROOT/applications/openMVG/openMVG/build/software/SfM/
    OPEN_MVG_SCRIPT_NAME=SfM_SequentialPipeline.py
    OPEN_MVG_DATA_FOLDER=$R_SRC_ROOT/applications/openMVG/Image_dataset/360_dataset/360_Flat/images
    OPEN_MVG_WEIGHT_FOLDER=$R_SRC_ROOT/applications/openMVG/openMVG/src/openMVG/exif/sensor_width_database
    OPEN_MVG_OUTPUT_FOLDER=$R_SRC_ROOT/applications/openMVG/output
fi

# Lanenet-Lane-detection
if [[ $1 == 'cross' ]]; then
    LANENET_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/bin/
    LANENET_LANE_DETECTION_BINARY_NAME=lanenet-lane-detection
    LANENET_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lanenet-lane-detection
else
    LANENET_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/lanenet-lane-detection
    LANENET_LANE_DETECTION_BINARY_NAME=lanenet-lane-detection
    LANENET_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/application/lanenet-lane-detection/lanenet-lane-detection/data/tusimple_test_image
    LANENET_LANE_DETECTION_PRELOAD_DIR=/usr/local/lib/python3.6/dist-packages/scikit_learn.libs/libgomp-d22c30c5.so.1.0.0
fi


# FLOAM:
if [[ $1 == 'cross' ]]; then
    FLOAM_BINARY_FOLDER=$R_SRC_ROOT/bin
    FLOAM_BINARY_NAME=floam
    #FLOAM_DATA_FOLDER=$R_SRC_ROOT/data
else
    FLOAM_BINARY_FOLDER=$R_SRC_ROOT/applications/odometry/floam/
    FLOAM_BINARY_NAME=floam
    #FLOAM_DATA_FOLDER=$R_SRC_ROOT/
fi


# YOLO ROS
# Lanenet-Lane-detection
if [[ $1 == 'cross' ]]; then
    DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/bin/
    DARKNET_ROS_BINARY_NAME=darknet_ros
    DARKNET_ROS__DATA_FOLDER=$R_SRC_ROOT/data/
else
    DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/applications/object_detection/darknet_ros
    DARKNET_ROS_BINARY_NAME=darknet_ros
    DARKNET_ROS_DATA_FOLDER=$R_SRC_ROOT/application/object_detection/darknet_ros/darknet_ros/yolo_network_config

fi

