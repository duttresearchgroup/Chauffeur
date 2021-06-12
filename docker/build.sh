#!/bin/bash

# Remove previous build
cd cross-apps/

target="/workspace/cross-apps"
source="/workspace/applications"

#   Build Jetson-Inference
build_jetson_inference () {
    mkdir -p $target/object_detection/jetson-inference && cd $target/object_detection/jetson-inference
    rm -rf build && mkdir -p build && cd build
    cmake \
        -DCUDA_nppicc_LIBRARY=/usr/local/cuda/targets/aarch64-linux/lib/stubs/libnppicc.so \
        -DBUILD_INTERACTIVE=NO \
        $source/object_detection/jetson-inference
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cd $target/object_detection/jetson-inference/build/aarch64/bin 
    target_images=$(readlink images)
    target_networks=$(readlink networks)
    rm -rf images && rm -rf networks
    cp -r $target_images . && cp -r $target_networks .
}

# Build Kalman filter
build_kalman_filter() {
    mkdir -p $target/kalman_filter/extended-kalman-filter && cd $target/kalman_filter/extended-kalman-filter
    rm -rf build && mkdir -p build && cd build
    cmake $source/kalman_filter/extended-kalman-filter
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
}

# Build Lane Detection
build_lane_detection() {
    mkdir -p $target/lane_detection/jetson-lane-detection && cd $target/lane_detection/jetson-lane-detection
    rm -rf build && mkdir -p build && cd build
    cmake $source/lane_detection/jetson-lane-detection
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    mv $source/lane_detection/jetson-lane-detection/bin $target/lane_detection/bin
    # -DJETSON_TX2=ON \
    # -DOpenCV_DIR=/usr/local/opencv2/share/OpenCV/OpenCVConfig-version.cmake \
}

build_cuda_lane_detection() {
    # nvcc -gencode arch=compute_62,code=sm_62 -I/usr/local/include/opencv4 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -std=c++11 -o $source/bin/cudaLaneDetection
    cd $source/lane_detection/cuda-lane-detection
    patch -b -p1 < $source/patches/cuda-lane-detection.patch
    mkdir -p $target/lane_detection/cuda-lane-detection && cd $target/lane_detection/cuda-lane-detection
    rm -rf build && mkdir -p build && cd build
    cmake $source/lane_detection/cuda-lane-detection
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cd $source/lane_detection/cuda-lane-detection
    patch -R -p1 < $source/patches/cuda-lane-detection.patch
    rm -rf *.orig
}


# Build OpenMVG
build_openmvg() {
    mkdir -p $target/openMVG/openMVG && cd $target/openMVG/openMVG
    rm -rf build && mkdir -p build && cd build
    cmake -DOpenMVG_USE_OCVSIFT=ON $source/structure_from_motion/open-mvg/src
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
    mkdir -p $target/localization_and_mapping/floam && cd $target/localization_and_mapping/floam
    rm -rf devel && rm -rf build && rm -rf install
    mkdir -p build && cd build
    cmake $source/localization_and_mapping/floam \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$target/localization_and_mapping/floam/devel \
        -DCMAKE_INSTALL_PREFIX=$target/localization_and_mapping/install \
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
    rm -rf $target/lane_detection/lanenet-lane-detection
    cp -r $source/lane_detection/lanenet-lane-detection $target/lane_detection/lanenet-lane-detection
}

build_lidar_tracking() {
    rm -rf $target/object_tracking/lidar-tracking
    source /opt/ros/melodic/setup.sh
    mkdir -p $target/object_tracking/lidar-tracking && cd $target/object_tracking/lidar-tracking
    rm -rf devel && rm -rf build
    mkdir -p build && cd build
    cmake $source/object_tracking/lidar-tracking \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$target/object_tracking/lidar-tracking/devel \
        -DCMAKE_INSTALL_PREFIX=$target/object_tracking/lidar-tracking/install \
        -DBUILD_SHARED_LIBS=OFF

    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install
    rm -rf $target/object_tracking/lidar-tracking/devel && \
        rm -rf $target/object_tracking/lidar-tracking/build
    
}

build_lidar_tracking() {
    rm -rf $target/object_tracking/lidar-tracking
    source /opt/ros/melodic/setup.sh
    mkdir -p $target/object_tracking/lidar-tracking && cd $target/object_tracking/lidar-tracking
    rm -rf devel && rm -rf build
    mkdir -p build && cd build
    cmake $source/object_tracking/lidar-tracking \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$target/object_tracking/lidar-tracking/devel \
        -DCMAKE_INSTALL_PREFIX=$target/object_tracking/lidar-tracking/install \
        -DBUILD_SHARED_LIBS=OFF

    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install
    rm -rf $target/object_tracking/lidar-tracking/devel && \
        rm -rf $target/object_tracking/lidar-tracking/build
    
}

build_orb_slam_3() {
    rm -rf $source/localization_and_mapping/orb-slam-3/Thirdparty/DBoW2/build
    rm -rf $source/localization_and_mapping/orb-slam-3/Thirdparty/g2o/build
    rm -rf $source/localization_and_mapping/orb-slam-3/Vocabulary/build
    rm -rf $source/localization_and_mapping/orb-slam-3/build

    cd $source/localization_and_mapping/orb-slam-3
    bash build.sh
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
build_lidar_tracking
build_orb_slam_3