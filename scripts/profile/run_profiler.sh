#!/bin/bash

export LC_TIME="POSIX"

if [[ $# -eq 0 ]];then
	echo "usage : sudo $0 [ running application ] [ output folder ] [px2/tx2]"
	echo "example : sudo $0 ../../kalman_filter/run.sh ../output/KF"
	exit 1
fi


mkdir -p $2

sample_interval=1
number_of_samples=1000

for x in "0" "0,3" "0,3,4" "0,3,4,5" "0,1,3,4,5" "0,1,2,3,4,5"
#for x in "0,1,2,3,4,5"
do
	mkdir -p $2/$x
	python3 main.py $1 --ipc --cpus $x --exectime --device $3 --output $2/$x/perf.log
done

./cat.sh $2
