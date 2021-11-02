#/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../envs.sh

[ -f $OPEN_MVG1_OUTPUT_LOGS ] && > $OPEN_MVG1_OUTPUT_LOGS
[ -f $OPEN_MVG2_OUTPUT_LOGS ] && > $OPEN_MVG2_OUTPUT_LOGS
[ -f $OPEN_MVG3_OUTPUT_LOGS ] && > $OPEN_MVG3_OUTPUT_LOGS
[ -f $OPEN_MVG4_OUTPUT_LOGS ] && > $OPEN_MVG4_OUTPUT_LOGS
[ -f $OPEN_MVG5_OUTPUT_LOGS ] && > $OPEN_MVG5_OUTPUT_LOGS
[ -f $OPEN_MVG6_OUTPUT_LOGS ] && > $OPEN_MVG6_OUTPUT_LOGS

sleep $WARM_UP_TIME

cd $WSS_FOLDER

while [ 1 ]
do
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_ComputeFeatures | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG1_OUTPUT_LOGS
sleep 1
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_ComputeMatches | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG2_OUTPUT_LOGS
sleep 1
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_IncrementalSfM | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG3_OUTPUT_LOGS
sleep 1
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_ComputeSfM_DataColor | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG4_OUTPUT_LOGS
sleep 1
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_ComputeStructureFromKnownPoses | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG5_OUTPUT_LOGS
sleep 1
./$WSS_BINARY_NAME -s 1 $(ps -aux | grep openMVG_main_ComputeSfM_DataColor | awk '{print $2}' | head -n 1) 0.1 >> $OPEN_MVG6_OUTPUT_LOGS
sleep 1
done
