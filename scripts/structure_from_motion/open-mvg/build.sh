#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "px2" ]];then
	cd ../../applications/structure_from_motion/open-mvg;mkdir build;cd build;cmake -DCMAKE_BUILD_TYPE=RELEASE ../src/;make -j$(nproc)
	mv Linux-aarch64-RELEASE/* software/SfM/.
fi


if [[ $1 == "tx2" ]];then
	cd ../../applications/structure_from_motion/open-mvg;mkdir build;cd build;cmake -DCMAKE_BUILD_TYPE=RELEASE ../src/;make -j$(nproc)
	mv Linux-aarch64-RELEASE/* software/SfM/.
fi


