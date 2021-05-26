#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

$DIR/01_init.sh $1
echo "[MiSelf] darknet_ros init complete"
$DIR/02_play.sh $1