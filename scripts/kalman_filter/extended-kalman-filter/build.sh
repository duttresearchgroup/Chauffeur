#!/bin/bash

cd ../../applications/kalman_filter/extended-kalman-filter/;mkdir build;cd build
cmake .. && make -j$(nproc)
