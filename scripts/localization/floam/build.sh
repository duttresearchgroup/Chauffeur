#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "px2" ]];then
	source /opt/ros/kinetic/setup.bash
	cd $R_SRC_ROOT/applications/localization/floam
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build && cd build
	cmake . \
		-DCMAKE_BUILD_TYPE=Release \
		-DCATKIN_DEVEL_PREFIX=$R_SRC_ROOT/applications/localization/floam/devel \
		-DBUILD_SHARED_LIBS=OFF
	make -j$(nproc)
fi

if [[ $1 == "tx2" ]];then
	source /opt/ros/melodic/setup.bash
	cd $R_SRC_ROOT/applications/localization/floam
	rm -rf devel && rm -rf build
	mkdir -p build && cd build
	cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCATKIN_DEVEL_PREFIX=$R_SRC_ROOT/applications/localization/floam/devel \
		-DBUILD_SHARED_LIBS=OFF
	make -j$(nproc)
fi
