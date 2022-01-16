source ./scripts/envs.sh

if [[ $# -eq 0 ]];then
	echo "usage : $0 [application num1], [application num2], ..."
    echo "The following is the end-to-end autonomous driving appications that you can launch: "
    echo "Num 2: Kalman filter (ExtendedKF)"
    echo "Num 3: Path Plannung (hybrid_astar)"
    echo "Num 4: Object Detection (darknet_ros)"
    echo "Num 5: Fast Lidar Odometry And Mapping (floam)"
    echo "Num 6: Lane Detection (cuda-lane-detection)"
    echo "Num 7: Structure from Motion (openMVG)"
    echo "Num 8: Lidar Tracking (lidar-tracking)"
    echo "Num 9: Localization (orb-slam-3)"
    echo "Num a: Launch all applications"
    exit 1
fi


for app_num in "$@" 
do
    case $app_num in
        2|3|4|5|6|7|8|9|a) 
            case $app_num in
                2)
                    echo "Profiling Kalman filter (ExtendedKF)"
                    python3 ./scripts/data_parser_memstat.py $EXTENDED_KALMAN_FILTER_MEMORY_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 & 
                    ;;
                3) 
                    echo "Profiling Path Plannung (hybrid_astar)"
                    python3 ./scripts/data_parser_memstat.py $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_1_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_2_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $HYBRID_ASTAR_MEMORY_OUTPUT_LOGS_3_ON_HOST > /dev/null 2>&1 &
                    ;;
                4)  
                    echo "Profiling Object Detection (darknet_ros)"
                    python3 ./scripts/data_parser_memstat.py $DARKNET_ROS_MEMORY_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    ;;
                5)
                    echo "Profiling Fast Lidar Odometry And Mapping (floam)"
                    python3 ./scripts/data_parser_memstat.py $FLOAM_MEMORY_OUTPUT_LOGS_1_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $FLOAM_MEMORY_OUTPUT_LOGS_2_ON_HOST > /dev/null 2>&1 &
                    ;;
                6)
                    echo "Profiling Lane Detection (cuda-lane-detection)"
                    python3 ./scripts/data_parser_memstat.py $CUDA_LANE_DETECTION_MEMORY_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    ;;
                7)
                    echo "Profiling Structure from Motion (openMVG)"
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG1_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG2_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG3_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG4_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG5_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    python3 ./scripts/data_parser_memstat.py $OPEN_MVG6_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    ;;
                8)
                    echo "Profiling Lidar Tracking (lidar-tracking)"
                    python3 ./scripts/data_parser_memstat.py $LIDAR_TRACKING_MEMORY_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    ;;
                9)
                    echo "Profiling Localization (orb-slam-3)"
                    python3 ./scripts/data_parser_memstat.py $ORBSLAM_MEMORY_OUTPUT_LOGS_ON_HOST > /dev/null 2>&1 &
                    ;;
                a)
                    ;;
            esac
            ;;
        *)             
            echo "Please enter valid application number!!!"
            echo "usage : $0 [application num1], [application num2], ..."
            echo "The following is the end-to-end autonomous driving appications that you can launch: "
            echo "Num 2: Kalman filter (ExtendedKF)"
            echo "Num 3: Path Plannung (hybrid_astar)"
            echo "Num 4: Object Detection (darknet_ros)"
            echo "Num 5: Fast Lidar Odometry And Mapping (floam)"
            echo "Num 6: Lane Detection (cuda-lane-detection)"
            echo "Num 7: Structure from Motion (openMVG)"
            echo "Num 8: Lidar Tracking (lidar-tracking)"
            echo "Num 9: Localization (orb-slam-3)"
            echo "Num a: Launch all applications"
            exit 1
            ;;
    esac
done

docker run -it --gpus all -v $(pwd)/logs:/workspace/logs --entrypoint "python3" x86.runner runner.py $@