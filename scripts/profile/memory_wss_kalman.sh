#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $KALMAN_MEMORY_OUTPUT_LOGS ] && > $KALMAN_MEMORY_OUTPUT_LOGS

sleep 1
cd $WSS_FOLDER
while [ 1 ]
do
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep ExtendedKF | awk '{print $2}' | head -n 1) 0.1 >> $KALMAN_MEMORY_OUTPUT_LOGS
done
