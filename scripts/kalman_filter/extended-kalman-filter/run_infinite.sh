
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh

cd $EXTENDED_KALMAN_FILTER_RUNNING_SCRIPT_FOLDER

while [ 1 ]
do
	time ./run.sh 
done 2>> $EXTENDED_KALMAN_FILTER_TIMING_LOGS
