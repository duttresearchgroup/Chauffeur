#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "px2" ]];then
	source /opt/ros/melodic/setup.bash
	cd $R_SRC_ROOT/applications/path_planning
	cd hybrid-astar && catkin_init_workspace
	rm -rf devel && rm -rf build && rm -rf install
	mkdir -p build
	cmake . \
		-DCMAKE_BUILD_TYPE=Release \
		-DCATKIN_DEVEL_PREFIX=devel \
		-DCMAKE_INSTALL_PREFIX=install \
		-DBUILD_SHARED_LIBS=OFF \

	make -j$(nproc)
fi

if [[ $1 == "tx2" ]];then
	source /opt/ros/melodic/setup.bash
	cd $R_SRC_ROOT/applications/path_planning
	cd hybrid-astar
	rm -rf devel && rm -rf build && rm -rf install
	cmake . \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=OFF
	make -j$(nproc)
fi
