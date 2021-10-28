DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash
source $DIR/../../envs.sh

[ -f $FLOAM_TIMING_LOGS ] && > $FLOAM_TIMING_LOGS

export LD_LIBRARY_PATH=/opt/ros/melodic/lib
while [ 1 ]
do
    roslaunch floam floam_chauffeur.launch
done
pkill roslaunch
pkill floam