#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash
source $DIR/../../envs.sh
[ -f $FLOAM_TIMING_LOGS] && > $FLOAM_TIMING_LOGS

export LD_LIBRARY_PATH=/opt/ros/melodic/lib

cd $FLOAM_RUNNING_SCRIPT_FOLDER


for i in 1
do
    ./run.sh "local"
done
