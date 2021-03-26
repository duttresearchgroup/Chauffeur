# /bin/bash

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
build_lane_detection(){
    cd $root/lane_detection
    rm -rf build && mkdir -p build && cd build
    cmake -DCMAKE_BUILD_TYPE=Debug  ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp ../bin/detect $root/bin/lane-detect
    # -DJETSON_TX2=ON \
    # -DOpenCV_DIR=/usr/local/opencv2/share/OpenCV/OpenCVConfig-version.cmake \
}


# # Build 3 FLOAM
build_floam(){
    cd $root/odometry/floam
    rm -rf build && mkdir -p build && cd build    
    cmake ..
}


# Build OpenMVG
build_openmvg(){
    cd $root/openMVG
    rm -rf build && mkdir -p build && cd build
    cmake $root/openMVG/openMVG/src
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
}


#  Build cuda-sfm
build_cuda_sfm() {
    cd $root/cuda-sfm
    rm -rf build && mkdir -p build && cd build
    cmake ..
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
    cp cuda-sfm $root/bin/cuda-sfm
}

# build_jetson_inference
# build_kalman_filter
build_lane_detection
# build_floam
# build_openmvg
# build_cuda_sfm