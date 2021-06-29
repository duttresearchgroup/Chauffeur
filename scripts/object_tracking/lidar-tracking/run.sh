#!/bin/bash

#source /home/donny/.bashrc
#source /home/nvidia/Workspace/Chauffeur/applications/object_detection/lidar-tracking/build/devel/setup.bash
#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [local/cross]"
fi

if [[ $1 == "local" ]];then

  source $HOME/catkin_ws/devel/setup.bash

  $HOME/catkin_ws/devel/lib/multi_object_tracking_lidar/kf_tracker
fi


if [[ $1 == "cross" ]];then
  source $R_SRC_ROOT/applications/object_tracking/lidar-tracking/install/setup.bash
  $R_SRC_ROOT/applications/object_tracking/lidar-tracking/install/lib/multi_object_tracking_lidar/kf_tracker
  
fi