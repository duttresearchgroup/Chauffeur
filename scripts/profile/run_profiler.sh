#!/bin/bash

export LC_TIME="POSIX"

if [[ $# -eq 0 ]];then
	echo "usage : sudo $0 [ running application ] [ output folder ]"
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
	mkdir -p $2/$x/sar_data
	mkdir -p $2/$x/graphs
	# CPU
	sar -u $sample_interval $number_of_samples | grep -v -E "CPU|Average|^$" > $2/$x/sar_data/cpu.dat &
	# RAM
	sar -r $sample_interval $number_of_samples | grep -v -E "[a-zA-Z]|^$" > $2/$x/sar_data/ram.dat &
	# Swap
	sar -S $sample_interval $number_of_samples | grep -v -E "[a-zA-Z]|^$" > $2/$x/sar_data/swap.dat &
	# IO transfer
	sar -b $sample_interval $number_of_samples | grep -v -E "[a-zA-Z]|^$" > $2/$x/sar_data/iotransfer.dat &
	# Process/context switches
	sar -w $sample_interval $number_of_samples | grep -v -E "[a-zA-Z]|^$" > $2/$x/sar_data/proc.dat &
	# Network Interface
	sar -n DEV $sample_interval $number_of_samples | grep "enp3s0" | grep -v "Average" > $2/$x/sar_data/netinterface.dat &
	# Sockets
	sar -n SOCK $sample_interval $number_of_samples | grep -v -E "[a-zA-Z]|^$" > $2/$x/sar_data/sockets.dat &
	sleep 5
	python3 main.py $1 --ipc --cpus $x --exectime --output $2/$x/perf.log
	sleep 5
	killall -SIGINT sar
	sleep 3
	mkdir -p ./tmp_data
	mkdir -p ./tmp_graphs

	cp $2/$x/sar_data/* ./tmp_data/.
	cd gnuplot
	
	gnuplot cpu.gplot
	gnuplot ram.gplot
	gnuplot swap.gplot
	gnuplot iotransfer.gplot
	gnuplot proc.gplot
	gnuplot contextsw.gplot
	gnuplot netinterface.gplot
	gnuplot sockets.gplot
	cd ..
	
	mv tmp_graphs/* $2/$x/graphs/.
	rm -rf ./tmp_data
	rm -rf ./tmp_graphs
done

./cat.sh $2
