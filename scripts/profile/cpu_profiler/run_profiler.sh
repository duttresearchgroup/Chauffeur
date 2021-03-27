#!/bin/bash


if [[ $# -eq 0 ]];then
	echo "usage : sudo $0 [ running application ] [ output folder ]"
	echo "example : sudo $0 ../../kalman_filter/run.sh ../output/KF"
	exit 1
fi


for x in "0" "0,1" "0,1,2" "0,1,2,3" "0,1,2,3,4" "0,1,2,3,4,5"
do
	python3 main.py $1 --ipc --cpus $x --exectime --output $2/$x.log
done

./cat.sh $2
