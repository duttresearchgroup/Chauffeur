#!/bin/bash

cd ../../applications/Kalman-Filter/;mkdir build;cd build
cmake .. && make -j$(nproc)
