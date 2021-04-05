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
rm -rf $R_SRC_ROOT/scripts/mars-data/*.csv
source $MARS_SCRIPTDIR/runtime/common.sh

for task in cuda-lane-detection kalman_filter lane_detection openMVG lanenet-lane-detection
do
    echo $task
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/run.sh > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh

    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done

# Special case for apps that require initialization
for task in darknet_ros
do
    echo $task
    $R_SRC_ROOT/scripts/$task/01_init.sh > /dev/null
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/02_play.sh > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh

    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done

for task in jetson_inference
do
    echo $task
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/run.sh imagenet video > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh

    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done

for task in lanenet-lane-detection
do
    echo $task
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    $R_SRC_ROOT/scripts/$task/run.sh video > /dev/null &
    wait
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh
done

for task in idle_power
do
    echo $task
    sudosh $MARS_SCRIPTDIR/runtime/start.sh miself
    sleep 10
    sudosh $MARS_SCRIPTDIR/runtime/stop.sh
    
    cp $RTS_DAEMON_OUTDIR/execTraceFine.csv $R_SRC_ROOT/scripts/mars-data/$task-fine_trace.csv
done
