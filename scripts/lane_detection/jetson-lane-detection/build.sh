#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

cd $R_SRC_ROOT/applications/lane_detection/jetson-lane-detection
rm -rf build && mkdir -p build && cd build
cmake ..
make -j$(nproc)
