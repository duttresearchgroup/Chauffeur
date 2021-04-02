#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "tx2" ]];then

	source /opt/ros/melodic/setup.sh
	cd ../../applications/odometry
	cd floam && catkin_init_workspace && cd ..
	rm -rf devel && rm -rf build && rm -rf install
	mkdir build && cd build
	cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=../devel \
        -DCMAKE_INSTALL_PREFIX=../install \
        -DBUILD_SHARED_LIBS=OFF

	make -j$(nproc)
	make install


fi
