#!/bin/bash

cd ../../applications;root=$(pwd)
echo $root
source /opt/ros/kinetic/setup.sh
cd object_detection
cd darknet_ros && catkin_init_workspace && cd ..
rm -rf devel && rm -rf build && rm -rf install
mkdir -p build && cd build
# [HACK] cv_bridge searches in /usr/include/opencv
ln -s /usr/local/include/opencv /usr/include/opencv
cmake $root/object_detection/darknet_ros \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$root/object_detection/devel \
        -DCMAKE_INSTALL_PREFIX=$root/object_detection/install \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS

make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
make install
mv $root/object_detection/install $root/bin/darknet_ros
rm -rf $root/object_detection/devel $root/object_detection/build

