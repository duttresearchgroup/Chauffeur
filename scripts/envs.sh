# Chimera

if [[ $1 == 'cross' ]]; then
    # export R_USER=deep
    # export R_PORT=-p22
    # export R_HOST=chimera.ics.uci.edu
    # export R_SRC_ROOT=/home/deep/workspace/Chauffeur
    export R_SRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
else
    export R_SRC_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."
fi

LOGS_FOLDER=/workspace/logs

# Jetson Lane Detection
# Info: cmake generates output in bin not build
JETSON_LANE_DETECTION_BINARY_FOLDER=$R_SRC_ROOT/applications/lane_detection/jetson-lane-detection/bin
JETSON_LANE_DETECTION_BINARY_NAME=detect
JETSON_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane_detection/jetson-lane-detection

# Extended Kalman Filter
EXTENDED_KALMAN_FILTER_BINARY_FOLDER=$R_SRC_ROOT/applications/kalman_filter/extended-kalman-filter/build
EXTENDED_KALMAN_FILTER_BINARY_NAME=ExtendedKF
EXTENDED_KALMAN_FILTER_DATA_FOLDER=$R_SRC_ROOT/data/kalman_filter/extended-kalman-filter
EXTENDED_KALMAN_FILTER_TIMING_LOGS=$LOGS_FOLDER/kf_time.txt
EXTENDED_KALMAN_FILTER_OUTPUT_LOGS=$LOGS_FOLDER/kf.txt
EXTENDED_KALMAN_FILTER_RUNNING_SCRIPT_FOLDER=$R_SRC_ROOT/scripts/kalman_filter/extended-kalman-filter
EXTENDED_KALMAN_FILTER_MEMORY_OUTPUT_LOGS=$LOGS_FOLDER/kf_memory.txt

# Jetson Inference
JETSON_INFERENCE_BINARY_FOLDER=$R_SRC_ROOT/applications/object_detection/jetson-inference/build/aarch64/bin
JETSON_INFERENCE_BINARY_NAME_IMAGENET=imagenet
JETSON_INFERENCE_BINARY_NAME_DETECTNET=detectnet
JETSON_INFERENCE_BINARY_NAME_SEGNET=segnet
JETSON_INFERENCE_DATA_FOLDER=$R_SRC_ROOT/applications/object_detection/jetson-inference/build/aarch64/bin

# Cuda Lane Detection
CUDA_LANE_DETECTION_ROOT_FOLDER=$R_SRC_ROOT/applications/lane_detection/cuda-lane-detection
CUDA_LANE_DETECTION_BINARY_NAME=cuda-lane-detection
CUDA_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane_detection/cuda-lane-detection
CUDA_LANE_DETECTION_RUNNING_SCRIPT_FOLDER=$R_SRC_ROOT/scripts/lane_detection/cuda-lane-detection
CUDA_LANE_DETECTION_OUTPUT_LOGS=$LOGS_FOLDER/cuda_lane_detection.txt
CUDA_LANE_DETECTION_TIMING_LOGS=$LOGS_FOLDER/cuda_lane_detection_time.txt
CUDA_LANE_DETECTION_OUTPUT_LOGS=$LOGS_FOLDER/cuda_lane_detection_memory.txt

# OpenMVG
OPEN_MVG_BINARY_FOLDER=$R_SRC_ROOT/applications/structure_from_motion/open-mvg/build/software/SfM/
OPEN_MVG_SCRIPT_NAME=SfM_SequentialPipeline.py
OPEN_MVG_DATA_FOLDER=$R_SRC_ROOT/data/structure_from_motion/open-mvg/Image_dataset/360_dataset/360_Flat/images
OPEN_MVG_WEIGHT_FOLDER=$R_SRC_ROOT/data/structure_from_motion/open-mvg
OPEN_MVG_OUTPUT_FOLDER=$R_SRC_ROOT/applications/structure_from_motion/open-mvg/output
OPEN_MVG_OUTPUT_LOGS=$LOGS_FOLDER/open_mvg.txt
OPEN_MVG_TIMING_LOGS=$LOGS_FOLDER/open_mvg_time.txt
OPEN_MVG_OUTPUT_LOGS=$LOGS_FOLDER/open_mvg_memory.txt

# Lanenet Lane Detection
LANENET_LANE_DETECTION_ROOT_FOLDER=$R_SRC_ROOT/applications/lane_detection/lanenet-lane-detection
LANENET_LANE_DETECTION_MODEL_FOLDER=$R_SRC_ROOT/data/lane_detection/lanenet-lane-detection
LANENET_LANE_DETECTION_PRELOAD_DIR=/usr/local/lib/python3.6/dist-packages/scikit_learn.libs/libgomp-d22c30c5.so.1.0.0
LANENET_LANE_DETECTION_DATA_FOLDER=$R_SRC_ROOT/data/lane_detection/lanenet-lane-detection

# FLOAM:
FLOAM_BINARY_FOLDER=$R_SRC_ROOT/applications/localization_and_mapping/floam/
FLOAM_BINARY_NAME=floam
FLOAM_DATA_FOLDER=$R_SRC_ROOT/data
FLOAM_TIMING_LOGS=$LOGS_FOLDER/floam_time.txt
FLOAM_RUNNING_SCRIPT_FOLDER=$R_SRC_ROOT/scripts/localization/floam
FLOAM_ROS_BAG_FOLDER=$R_SRC_ROOT/data
FLOAM_MEMORY_OUTPUT_LOGS=$LOGS_FOLDER/floam.txt

# Hybrid A* Path Planner:
HYBRID_ASTAR_BINARY_FOLDER=$R_SRC_ROOT/applications/path_planning/hybrid-astar
HYBRID_ASTAR_BINARY_NAME=hybrid_astar
HYBRID_ASTAR_DATA_FOLDER=$R_SRC_ROOT/data/path_planning/hybrid-astar/maps
HYBRID_ASTAR_TIMING_LOGS=$LOGS_FOLDER/h_a_star_time.txt
HYBRID_ASTAR_OUTPUT_LOGS=$LOGS_FOLDER/h_a_star.txt
HYBRID_ASTAR_RUNNING_SCRIPT_FOLDER=$R_SRC_ROOT/scripts/path_planning/hybrid-astar
HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_1=$LOGS_FOLDER/h_a_star_map_server_memory.txt
HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_2=$LOGS_FOLDER/h_a_star_tf_broadcaster_memory.txt
HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_3=$LOGS_FOLDER/h_a_star_h_a_star_memory.txt
# YOLO ROS
DARKNET_ROS_BINARY_FOLDER=$R_SRC_ROOT/applications/object_detection/darknet-ros/install
DARKNET_ROS_BINARY_NAME=darknet_ros
DARKNET_ROS_LABELS_FOLDER=$R_SRC_ROOT/data/object_detection/darknet-ros
DARKNET_ROS_BAG_FOLDER=$R_SRC_ROOT/data
DARKNET_ROS_TIMING_LOGS=$LOGS_FOLDER/darknet_ros_time.txt
DARKNET_ROS_OUTPUT_LOGS=$LOGS_FOLDER/darknet_ros.txt
DARKNET_ROS_MEMORY_OUTPUT_LOGS=$LOGS_FOLDER/darknet_ros_memory.txt

# ORB-SLAM-3
ORBSLAM_BINARY_FOLDER=$R_SRC_ROOT/applications/localization_and_mapping/orb-slam-3
ORBSLAM_DATA_FOLDER=$R_SRC_ROOT/data
ORBSLAM_TIMING_LOGS=$LOGS_FOLDER/orb_slam_3_time.txt
ORBSLAM_RUNNING_SCRIPT_FOLDER=$R_SRC_ROOT/scripts/localization/orb-slam-3
ORBSLAM_MEMORY_OUTPUT_LOGS=$LOGS_FOLDER/orb_slam_3_memory.txt

#LIDAR TRACKING
LIDAR_TRACKING_OUTPUT_LOGS=$LOGS_FOLDER/lidar_tracking.txt
LIDAR_TRACKING_MEMORY_OUTPUT_LOGS=$LOGS_FOLDER/lidar_tracking_memory.txt

#PROFILE
WSS_FOLDER=$R_SRC_ROOT/scripts/end-to-end/wss
WSS_BINARY_NAME=wss.pl
