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
        2|3|4|5|6|7|8|9|a|"${@: -1}") 
            case $app_num in
                2)
                    echo "Profiling Kalman filter (ExtendedKF)"
                    ;;
                3) 
                    echo "Profiling Path Plannung (hybrid_astar)"
                    ;;
                4)  
                    echo "Profiling Object Detection (darknet_ros)"
                    ;;
                5)
                    echo "Profiling Fast Lidar Odometry And Mapping (floam)"
                    ;;
                6)
                    echo "Profiling Lane Detection (cuda-lane-detection)"
                    ;;
                7)
                    echo "Profiling Structure from Motion (openMVG)"
                    ;;
                8)
                    echo "Profiling Lidar Tracking (lidar-tracking)"
                    ;;
                9)
                    echo "Profiling Localization (orb-slam-3)"
                    ;;
                "${@: -1}")
                    echo "The logs will be written in folder ${@: -1}"
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

last_element=$(expr $# - 1)

docker run -it --gpus all -v $(pwd)/logs/${@: -1}:/workspace/logs --entrypoint "python3" x86.runner runner.py ${@:1:$last_element} 
