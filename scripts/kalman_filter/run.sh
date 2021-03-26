#/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh $1

cd $KALMAN_FILTER_BINARY_FOLDER
./$KALMAN_FILTER_BINARY_NAME $KALMAN_FILTER_DATA_FOLDER/sample-laser-radar-measurement-data-1.txt output.txt
