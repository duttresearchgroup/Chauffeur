#!/bin/bash

#source /home/donny/.bashrc
#source /home/nvidia/Workspace/Chauffeur/applications/object_detection/lidar-tracking/build/devel/setup.bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/object_tracking/lidar-tracking;

source devel/setup.bash

while [ 1 ]
do
devel/lib/multi_object_tracking_lidar/kf_tracker
done

