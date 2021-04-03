#!/bin/bash

if [ -z ${MARS_SCRIPTDIR+x} ]; then 
    echo "Please source MARS envs.sh variables before running experiments"; 
    exit 1
fi

if [ -z ${R_SRC_ROOT+x} ]; then 
    echo "Please source Chauffer envs.sh variables before running experiments"; 
    exit 1
fi

mkdir -p $R_SRC_ROOT/scripts/mars-data/
source $MARS_SCRIPTDIR/runtime/common.sh

for task in cuda-lane-detection jetson_inference kalman_filter lane_detection openMVG
do
    echo $task
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/run.sh cross > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh

    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done

# Special case for apps that require initialization
for task in darknet_ros
do
    echo $task
    $R_SRC_ROOT/scripts/$task/01_init.sh cross > /dev/null
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/02_play.sh cross > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh

    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done