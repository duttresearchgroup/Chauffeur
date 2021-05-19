#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "px2" ]];then
	cd ../../applications;root=$(pwd)
	echo $root
	source /opt/ros/kinetic/setup.sh
	cd object_detection
	cd darknet-ros && catkin_init_workspace
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build && cd build
	cmake $root/applications/object_detection/darknet-ros \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$root/applications/object_detection/darknet-ros/devel \
        -DCMAKE_INSTALL_PREFIX=$root/applications/object_detection/darknet-ros/install \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS

	make -j"$(grep ^processor /proc/cpuinfo | wc -l)"
	make install
	mv $root/object_detection/install $root/bin/darknet-ros
	rm -rf $root/object_detection/devel $root/object_detection/build
fi

if [[ $1 == "tx2" ]];then
	source /opt/ros/melodic/setup.bash
	cd $R_SRC_ROOT/applications/object_detection/darknet-ros
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build && cd build
	cmake $R_SRC_ROOT/applications/object_detection/darknet-ros \
		-DCMAKE_BUILD_TYPE=Release \
		-DCATKIN_DEVEL_PREFIX=$R_SRC_ROOT/applications/object_detection/darknet-ros/devel \
		-DCMAKE_INSTALL_PREFIX=$R_SRC_ROOT/applications/object_detection/darknet-ros/install \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS

	make -j$(nproc)
	make install


fi
