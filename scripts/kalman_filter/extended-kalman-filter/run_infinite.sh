
#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $EXTENDED_KALMAN_FILTER_BINARY_FOLDER
while [ 1 ]
do
	{ time ./$EXTENDED_KALMAN_FILTER_BINARY_NAME $EXTENDED_KALMAN_FILTER_DATA_FOLDER/sample-laser-radar-measurement-data-1.txt output.txt >> /workspace/logs/kf.txt 2>&1 ; } 2>> /workspace/logs/time_kf.txt
done
