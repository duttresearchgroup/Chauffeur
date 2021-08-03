#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [ output folder ]"
	echo "example : $0 ../output/KF"
	exit 1
fi


for x in "0" "0,3" "0,3,4" "0,3,4,5" "0,1,3,4,5" "0,1,2,3,4,5"
do
	cat $1/$x/perf.log
	echo " "
done
