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
cd $root
rm -rf *
cmake $root/../Kalman-Filter -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake
make
cp ExtendedKF ../bin/ExtendedKF

# Build 2
cd $root
rm -rf *

# Build 3
cd $root
rm -rf *

# Cleanup temporary folder
rm -rf $root