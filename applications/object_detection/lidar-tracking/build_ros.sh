echo "Building ROS nodes"

mkdir build
cd build
cmake .. -DROS_BUILD_TYPE=Release
make -j6
