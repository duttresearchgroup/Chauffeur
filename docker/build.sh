#!/bin/bash

# Remove previous build
cd cross-apps/

target="/workspace/cross-apps"
source="/workspace/applications"

#   Build Jetson-Inference
build_jetson_inference () {
    mkdir -p $target/jetson-inference && cd $target/jetson-inference
    rm -rf build && mkdir -p build && cd build
    cmake \
        -DCUDA_nppicc_LIBRARY=/usr/local/cuda/targets/aarch64-linux/lib/stubs/libnppicc.so \
        -DBUILD_INTERACTIVE=NO \
        $source/jetson-inference
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cd $target/jetson-inference/build/aarch64/bin 
    target_images=$(readlink images)
    target_networks=$(readlink networks)
    rm -rf images && rm -rf networks
    cp -r $target_images . && cp -r $target_networks .
}

# Build Kalman filter
build_kalman_filter() {
    mkdir -p $target/Kalman-Filter && cd $target/Kalman-Filter
    rm -rf build && mkdir -p build && cd build
    cmake $source/Kalman-Filter
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
}

# Build Lane Detection
build_lane_detection() {
    mkdir -p $target/lane_detection && cd $target/lane_detection
    rm -rf build && mkdir -p build && cd build
    cmake $source/lane_detection
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    mv $source/lane_detection/bin $target/lane_detection/bin
    # -DJETSON_TX2=ON \
    # -DOpenCV_DIR=/usr/local/opencv2/share/OpenCV/OpenCVConfig-version.cmake \
}

build_cuda_lane_detection() {
    # nvcc -gencode arch=compute_62,code=sm_62 -I/usr/local/include/opencv4 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -std=c++11 -o $source/bin/cudaLaneDetection
    cd $source/cuda-lane-detection
    patch -b -p1 < $source/patches/cuda-lane-detection.patch
    mkdir -p $target/cuda-lane-detection && cd $target/cuda-lane-detection
    rm -rf build && mkdir -p build && cd build
    cmake $source/cuda-lane-detection
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cd $source/cuda-lane-detection
    patch -R -p1 < $source/patches/cuda-lane-detection.patch
    rm -rf *.orig
}


# Build OpenMVG
build_openmvg() {
    mkdir -p $target/openMVG/openMVG && cd $target/openMVG/openMVG
    rm -rf build && mkdir -p build && cd build
    cmake -DOpenMVG_USE_OCVSIFT=ON $source/openMVG/openMVG/src
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    mv Linux-aarch64-Release/* software/SfM/.
}

#  Build darknet_ros
build_darknet_ros() {
    source /opt/ros/melodic/setup.sh
    mkdir -p $target/object_detection/darknet_ros && cd $target/object_detection/darknet_ros
    rm -rf devel && rm -rf build
    mkdir -p build && cd build
    # [HACK] cv_bridge searches in /usr/include/opencv
    ln -s /usr/local/include/opencv /usr/include/opencv
    cmake $source/object_detection/darknet_ros \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$target/object_detection/darknet_ros/devel \
        -DCMAKE_INSTALL_PREFIX=$target/object_detection/darknet_ros/install \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS

    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install
    rm -rf $target/object_detection/darknet_ros/devel && \
        rm -rf $target/object_detection/darknet_ros/build
}


# Build 3 FLOAM
build_floam() {
    source /opt/ros/melodic/setup.sh
    mkdir -p $target/odometry/floam && cd $target/odometry/floam
    rm -rf devel && rm -rf build && rm -rf install
    mkdir -p build && cd build
    cmake $source/odometry/floam \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$target/odometry/floam/devel \
        -DCMAKE_INSTALL_PREFIX=$target/odometry/install \
        -DBUILD_SHARED_LIBS=OFF

    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    make install
}

# Build path planner
build_path_planning() {
    source /opt/ros/melodic/setup.sh
    mkdir -p $target/path_planning/hybrid-astar && cd $target/path_planning/hybrid-astar
    rm -rf devel && rm -rf build && rm -rf install
    mkdir -p build && cd build
    cmake $source/path_planning/hybrid-astar \
        -DCMAKE_BUILD_TYPE=Release \
        -Dcatkin_DIR=/opt/ros/melodic/share/catkin/cmake/catkinConfig.cmake \
        -DCATKIN_DEVEL_PREFIX=$target/path_planning/hybrid-astar/devel \
        -DCMAKE_INSTALL_PREFIX=$target/path_planning/hybrid-astar \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_CXX_FLAGS=-I/usr/include/eigen3

    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install
    rm -rf $target/path_planning/hybrid-astar/devel && \
        rm -rf $target/path_planning/hybrid-astar/build
}


build_lanenet_lane_detection() {
    rm -rf $target/lanenet-lane-detection
    cp -r $source/lanenet-lane-detection $target/lanenet-lane-detection
}

build_jetson_inference
build_kalman_filter
build_lane_detection
build_cuda_lane_detection
build_lanenet_lane_detection
build_openmvg
build_darknet_ros
build_floam
build_path_planning