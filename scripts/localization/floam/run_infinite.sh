#!/bin/bash

DIR=$1
cd $1/applications/applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash

while [ 1 ]
do
roslaunch --wait floam floam.launch
done
