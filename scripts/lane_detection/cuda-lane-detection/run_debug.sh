DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $DIR/../../envs.sh
cd $CUDA_LANE_DETECTION_RUNNING_SCRIPT_FOLDER

[ -f $CUDA_LANE_DETECTION_TIMING_LOGS ] && > $CUDA_LANE_DETECTION_TIMING_LOGS
[ -f $CUDA_LANE_DETECTION_OUTPUT_LOGS ] && > $CUDA_LANE_DETECTION_OUTPUT_LOGS
while [ 1 ]
do
    time ./run.sh
done
