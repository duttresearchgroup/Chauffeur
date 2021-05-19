#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "tx2" ]];then

	cd ../../applications/object_detection/jetson-inference
	rm -rf build && mkdir build && cd build
	cmake ..
	make -j$(nproc)
	sudo make install
	sudo ldconfig
	cd /usr/lib/aarch64-linux-gnu
	sudo ln -sf libdrm.so.2.4.0 libdrm.so.2
fi
