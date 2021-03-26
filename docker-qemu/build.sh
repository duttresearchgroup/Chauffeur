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
    rm -rf ../CMakeLists.txt
    cp cuda-lane-detection $root/bin/cuda-lane-detection
    cd ..
    rm -rf build
    patch -R -p1 < $root/patches/cuda-lane-detection.patch
    rm -rf *.orig
}


# Build 3 FLOAM
# UNDER CONSTRUCTION
build_floam() {
    cd $root/odometry/floam
    rm -rf build && mkdir -p build && cd build    
    cmake ..
}


# Build OpenMVG
# UNDER CONSTRUCTION
build_openmvg() {
    cd $root/openMVG
    rm -rf build && mkdir -p build && cd build
    cmake $root/openMVG/openMVG/src
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
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

build_jetson_inference
build_kalman_filter
build_lane_detection
build_cuda_lane_detection
# build_floam
# build_openmvg
# build_cuda_sfm