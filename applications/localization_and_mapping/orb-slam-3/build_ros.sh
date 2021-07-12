echo "Building ROS nodes"

export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:$PWD/ORB_SLAM3/Examples/ROS
cd Examples/ROS/ORB_SLAM3
mkdir build
cd build
cmake .. -DROS_BUILD_TYPE=Release
make -j
