#!/bin/bash

DIR=$HOME/workspace/Chauffeur
cd $DIR/applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash

while [ 1 ]
do
roslaunch --wait floam floam_chauffeur.launch
done
