DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash

for i in 1
do

roslaunch --wait floam floam_chauffeur.launch

done