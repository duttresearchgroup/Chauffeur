DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $DIR/../../../applications/localization_and_mapping/floam;
source /opt/ros/melodic/setup.bash
source devel/setup.bash
<<<<<<< HEAD
=======

#[ -f $FLOAM_TIMING_LOGS] && > $FLOAM_TIMING_LOGS

export LD_LIBRARY_PATH=/opt/ros/melodic/lib
>>>>>>> 13537e4dacd49b33f8e5913934f4619b6b51398f

while [ 1 ]
do
<<<<<<< HEAD

roslaunch --wait floam floam_chauffeur.launch

done
=======
    roslaunch --wait floam floam_chauffeur.launch
done
>>>>>>> 13537e4dacd49b33f8e5913934f4619b6b51398f
