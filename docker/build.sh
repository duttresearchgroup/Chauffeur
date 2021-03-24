# /bin/bash

# Remove previous build
rm -rf applications/bin
rm -rf applications/tmp

export PATH=$NVIDIA_TOOLCHAIN_PATH/bin:$PATH
export CROSS_COMPILE=aarch64-linux-gnu-

# Create new binary folder for all the generated executables
mkdir -p applications/bin

# Create temporary folder for compilation
mkdir -p applications/tmp
cd applications/tmp

root=$(pwd)

# Build Kalman filter
# cd $root
# rm -rf *
# cmake $root/../Kalman-Filter -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake
# make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
# cp ExtendedKF ../bin/ExtendedKF

# Build 2
# Lane Detection
# cd $root
# rm -rf *
# cmake -DBoost_DEBUG=ON -DJETSON_TX2=ON -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake $root/../lane_detection
# make
# rm -rf *

# # Build 3 FLOAM
# cd $root
# rm -rf *
# cmake -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake $root/../odometry/floam

#  Build OpenMVG
cd $root
rm -rf *
cmake -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake $root/../openMVG/openMVG/src


# # Cleanup temporary folder
# rm -rf $root