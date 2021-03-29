#!/bin/bash

# Remove previous build
rm -rf applications/bin

# Create new binary folder for all the generated executables
mkdir -p applications/bin

# Create temporary folder for compilation
mkdir -p applications
cd applications

root=$(pwd)

#   Build Jetson-Inference
build_jetson_inference () {
  cd $root/jetson-inference 
    rm -rf build && mkdir -p build && cd build
    cmake \
        -DCUDA_nppicc_LIBRARY=/usr/local/cuda/targets/aarch64-linux/lib/stubs/libnppicc.so \
        -DBUILD_INTERACTIVE=NO \
        ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    rm -rf $root/bin/jetson-inference/
    cp -r aarch64 $root/bin/jetson-inference
}

# Build Kalman filter
build_kalman_filter() {
    cd $root/Kalman-Filter  
    rm -rf build && mkdir -p build && cd build
    cmake ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp ExtendedKF $root/bin/ExtendedKF
}

# Build Lane Detection
build_lane_detection() {
    cd $root/lane_detection
    rm -rf build && mkdir -p build && cd build
    cmake ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp ../bin/detect $root/bin/lane-detect
    # -DJETSON_TX2=ON \
    # -DOpenCV_DIR=/usr/local/opencv2/share/OpenCV/OpenCVConfig-version.cmake \
}

build_cuda_lane_detection() {
    # nvcc -gencode arch=compute_62,code=sm_62 -I/usr/local/include/opencv4 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -std=c++11 -o $root/bin/cudaLaneDetection
    cd $root/cuda-lane-detection
    patch -b -p1 < $root/patches/cuda-lane-detection.patch
    rm -rf build && mkdir -p build && cd build
    cmake ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp cuda-lane-detection $root/bin/cuda-lane-detection
    cd ..
    rm -rf build
    patch -R -p1 < $root/patches/cuda-lane-detection.patch
    rm -rf *.orig
}


# Build OpenMVG
build_openmvg() {
    cd $root/openMVG
    rm -rf build && mkdir -p build && cd build
    cmake -DOpenMVG_USE_OCVSIFT=ON $root/openMVG/openMVG/src
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp -r Linux-aarch64-Release $root/bin/openMVG
    cp software/SfM/SfM_SequentialPipeline.py $root/bin/openMVG/SfM_SequentialPipeline.py
}

#  Build darknet_ros
build_darknet_ros() {
    source /opt/ros/melodic/setup.sh
    cd $root/object_detection
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
}


# Build 3 FLOAM
# UNDER CONSTRUCTION
build_floam() {
    source /opt/ros/melodic/setup.sh
    cd $root/odometry
    cd floam && catkin_init_workspace && cd ..
    rm -rf devel && rm -rf build && rm -rf install
    mkdir -p build && cd build
    cmake $root/odometry/floam \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$root/odometry/devel \
        -DCMAKE_INSTALL_PREFIX=$root/odometry/install \
        -DBUILD_SHARED_LIBS=OFF
}



#  Build cuda-sfm
# UNDER CONSTRUCTION
build_cuda_sfm() {
    cd $root/cuda-sfm
    rm -rf build && mkdir -p build && cd build
    cmake ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp cuda-sfm $root/bin/cuda-sfm
}

# build_jetson_inference
# build_kalman_filter
# build_lane_detection
# build_cuda_lane_detection
# build_floam
# build_openmvg
# build_cuda_sfm
build_darknet_ros
# build_floam