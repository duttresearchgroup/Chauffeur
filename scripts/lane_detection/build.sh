#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
fi

if [[ $1 == "tx2" ]];then
	cd ../../applications/lane_detection
	rm -rf build && mkdir -p build && cd build
    	cmake ..
	make -j$(nproc)
fi
