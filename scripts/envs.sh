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

    # export R_USER=drg
    # export R_PORT=-p60000
    # export R_HOST=hylo.asuscomm.com
    # export R_SRC_ROOT=/home/saehansy/Workspace/biton

else
    export R_SRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
fi

# Lane Detection
LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/lane_detection/bin
LANE_DETECTION_BINARY_NAME=detect
LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane_detection

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
    JETSON_INFERENCE_BINARY_NAME_IMAGENET=imagenet
    JETSON_INFERENCE_BINARY_NAME_DETECTNET=detectnet
    JETSON_INFERENCE_BINARY_NAME_SEGNET=segnet
    JETSON_INFERENCE_DATA_FOLDER=$R_SRC_ROOT/applications/jetson-inference/build/aarch64/bin
fi

# Cuda Lane Detection
CUDA_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection
CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/cuda-lane-detection

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
    FLOAM_DATA_FOLDER=$R_SRC_ROOT/data
else
    FLOAM_BINARY_FOLDER=$R_SRC_ROOT/applications/odometry/floam/
    FLOAM_BINARY_NAME=floam
    FLOAM_DATA_FOLDER=$R_SRC_ROOT/data
fi

# Hybrid A* Path Planner:
if [[ $1 == 'cross' ]]; then
    HYBRID_ASTAR_BINARY_FOLDER=$R_SRC_ROOT/bin
    HYBRID_ASTAR_BINARY_NAME=hybrid_astar
    HYBRID_ASTAR_DATA_FOLDER=$R_SRC_ROOT/data
else
    HYBRID_ASTAR_BINARY_FOLDER=$R_SRC_ROOT/applications/path_planning/hybrid-astar/
    HYBRID_ASTAR_BINARY_NAME=hybrid_astar
    HYBRID_ASTAR_DATA_FOLDER=$HYBRID_ASTAR_BINARY_FOLDER/maps
fi

# YOLO ROS
if [[ $1 == 'cross' ]]; then
    DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/bin/darknet_ros
    DARKNET_ROS_BINARY_NAME=darknet_ros
    DARKNET_ROS_LABELS_FOLDER=$R_SRC_ROOT/data/darknet_ros
    DARKNET_ROS_BAG_FOLDER=$R_SRC_ROOT/data/darknet_ros
else
    DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/applications/object_detection/install
    DARKNET_ROS_BINARY_NAME=darknet_ros
    DARKNET_ROS_LABELS_FOLDER=$R_SRC_ROOT/applications/object_detection/darknet_ros/darknet/data
    DARKNET_ROS_BAG_FOLDER=$R_SRC_ROOT/..
fi

