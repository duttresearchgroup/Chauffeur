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
	cd darknet_ros && catkin_init_workspace && cd ..
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build && cd build
	cmake $root/object_detection/darknet_ros \
        -DCMAKE_BUILD_TYPE=Release \
        -DCATKIN_DEVEL_PREFIX=$root/object_detection/devel \
        -DCMAKE_INSTALL_PREFIX=$root/object_detection/install \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS

	make -j"$(grep ^processor /proc/cpuinfo | wc -l)" 
	make install
	mv $root/object_detection/install $root/bin/darknet_ros
	rm -rf $root/object_detection/devel $root/object_detection/build
fi

if [[ $1 == "tx2" ]];then
	source /opt/ros/melodic/setup.bash
	cd $R_SRC_ROOT/applications/object_detection
	cd darknet_ros && catkin_init_workspace && cd ..
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build && cd build
	cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCATKIN_DEVEL_PREFIX=../devel \
		-DCMAKE_INSTALL_PREFIX=../install \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_CXX_FLAGS=-DCV__ENABLE_C_API_CTORS
    	
	make -j$(nproc)
	make install


fi
