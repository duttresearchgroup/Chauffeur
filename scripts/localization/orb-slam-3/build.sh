#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [px2/tx2]"
	exit 1
fi

if [[ $1 == "tx2" ]]; then
	cd $R_SRC_ROOT/applications/localization_and_mapping/orb-slam-3
	chmod +x build.sh
	bash build.sh

fi