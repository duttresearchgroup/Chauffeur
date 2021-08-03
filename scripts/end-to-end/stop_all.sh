#!/bin/bash

#roscore

killall -9 roscore rosmaster rosout

#rosbag
killall -9 rosbag

#EKF
killall -9 ExtendedKF

#path-planner
killall -9 hybrid_astar map_server tf_broadcaster

# darknet_ros floam
killall -9 test.sh
killall -9 roslaunch
killall -9 darknet_ros
killall -9 floam_odom_estimation_node
killall -9 floam_laser_processing_node
killall -9 static_transform_publisher
killall -9 python
killall -9 cuda-lane-detection

killall -9 run_infinite.sh
killall -9 hector_trajectory_server
