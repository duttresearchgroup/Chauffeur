#!/bin/bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/orb-slam-3/Examples/ROS/ORB_SLAM3/build;
source $DIR/../../envs.sh

[ -f $ORBSLAM_TIMING_LOGS ] && > $ORBSLAM_TIMING_LOGS

cd $ORBSLAM_RUNNING_SCRIPT_FOLDER
source run_debug.sh 1>> $ORBSLAM_TIMING_LOGS