# /bin/bash

# Remove previous build
rm -rf applications/bin

# Create new binary folder for all the generated executables
mkdir -p applications/bin

# Create temporary folder for compilation
mkdir -p applications
cd applications

root=$(pwd)

# #   Build Jetson-Inference
# cd $root/jetson-inference 
# rm -rf build && mkdir -p build && cd build
# cmake \
#     -DCUDA_nppicc_LIBRARY=/usr/local/cuda/targets/aarch64-linux/lib/stubs/libnppicc.so \
#     -DBUILD_INTERACTIVE=NO \
#     ..
# make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
# rm -rf $root/bin/jetson-inference/
# cp -r aarch64 $root/bin/jetson-inference

# # Build Kalman filter
# cd $root/Kalman-Filter
# rm -rf build && mkdir -p build && cd build
# cmake ..
# make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
# cp ExtendedKF $root/bin/ExtendedKF

# Build Lane Detection
# cd $root/lane_detection
# rm -rf build && mkdir -p build && cd build
# cmake \
#     -DJETSON_TX2=ON \
#     ..

#     -DOpenCV_DIR=/usr/aarch64-linux-gnu/lib/cmake/opencv4 \
# make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 

# # Build 3 FLOAM
# cd $root
# rm -rf *
# cmake -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake $root/../odometry/floam

#  Build OpenMVG
# cd $root/openMVG
# rm -rf build && mkdir -p build && cd build
# cmake $root/openMVG/openMVG/src
# make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
# # Cleanup temporary folder
# rm -rf $root