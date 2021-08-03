#!/bin/bash
cd $R_SRC_ROOT/applications/kalman_filter/extended-kalman-filter/;mkdir build;cd build
cmake .. && make -j$(nproc)
