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
# Info: lane_detection cmake generates output in bin not build
LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/lane_detection/bin
LANE_DETECTION_BINARY_NAME=detect
LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane_detection

# Kalman Filter
KALMAN_FILTER_BINARY_FOLDER=$R_SRC_ROOT/applications/Kalman-Filter/build
KALMAN_FILTER_BINARY_NAME=ExtendedKF
KALMAN_FILTER_DATA_FOLDER=$R_SRC_ROOT/data/Kalman-Filter

# Jetson Inference
JETSON_INFERENCE_BINARY_FOLDER=$R_SRC_ROOT/applications/jetson-inference/build/aarch64/bin
JETSON_INFERENCE_BINARY_NAME_IMAGENET=imagenet
JETSON_INFERENCE_BINARY_NAME_DETECTNET=detectnet
JETSON_INFERENCE_BINARY_NAME_SEGNET=segnet
JETSON_INFERENCE_DATA_FOLDER=$R_SRC_ROOT/applications/jetson-inference/build/aarch64/bin

# Cuda Lane Detection
CUDA_LANE_DETECTION_ROOT_FOLDER=$R_SRC_ROOT/applications/cuda-lane-detection
CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/cuda-lane-detection

# OpenMVG
OPEN_MVG_BINARY_FOLDER=$R_SRC_ROOT/applications/openMVG/openMVG/build/software/SfM/
OPEN_MVG_SCRIPT_NAME=SfM_SequentialPipeline.py
OPEN_MVG_DATA_FOLDER=$R_SRC_ROOT/data/openMVG/Image_dataset/360_dataset/360_Flat/images
OPEN_MVG_WEIGHT_FOLDER=$R_SRC_ROOT/data/openMVG
OPEN_MVG_OUTPUT_FOLDER=$R_SRC_ROOT/applications/openMVG/output

# Lanenet-Lane-detection
LANENET_LANE_DETECTION_ROOT_FOLDER=$R_SRC_ROOT/applications/lanenet-lane-detection
LANENET_LANE_DETECTION_MODEL_FOLDER=$R_SRC_ROOT/data/lanenet-lane-detection
LANENET_LANE_DETECTION_PRELOAD_DIR=/usr/local/lib/python3.6/dist-packages/scikit_learn.libs/libgomp-d22c30c5.so.1.0.0
LANENET_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lanenet-lane-detection

# FLOAM:
FLOAM_BINARY_FOLDER=$R_SRC_ROOT/applications/odometry/floam/
FLOAM_BINARY_NAME=floam
FLOAM_DATA_FOLDER=$R_SRC_ROOT/data

# Hybrid A* Path Planner:
HYBRID_ASTAR_BINARY_FOLDER=$R_SRC_ROOT/applications/path_planning/hybrid-astar/
HYBRID_ASTAR_BINARY_NAME=hybrid_astar
HYBRID_ASTAR_DATA_FOLDER=$HYBRID_ASTAR_BINARY_FOLDER/maps

# YOLO ROS
DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/applications/object_detection/darknet_ros/install
DARKNET_ROS_BINARY_NAME=darknet_ros
DARKNET_ROS_LABELS_FOLDER=$R_SRC_ROOT/data/darknet_ros
DARKNET_ROS_BAG_FOLDER=$R_SRC_ROOT/data
