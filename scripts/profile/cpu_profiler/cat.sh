#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "usage : $0 [ output folder ]"
	echo "example : $0 ../output/KF"
	exit 1
fi


cat $1/0.log
echo " "
cat $1/0,1.log
echo " "
cat $1/0,1,2.log
echo " "
cat $1/0,1,2,3.log
echo " "
cat $1/0,1,2,3,4.log
echo " "
cat $1/0,1,2,3,4,5.log
