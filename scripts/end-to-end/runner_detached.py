import psutil
import sys
import time
import os
import signal
import subprocess

command_in = False
command = -1

ROOT=""
ROSBAG="./rosbag.sh"

def checkIfProcessRunning(processName):
    #Iterate over the all the running process
    for proc in psutil.process_iter():
        try:
            # Check if process name contains the given name string.
            if processName.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False

def displaySystemUtil():
    print("cpu usage percent: " + str(psutil.cpu_percent()))
    print("mem usage percent: " + str(psutil.virtual_memory().percent))

def sigintHandler(signal, frame):
    global command_in, command
    print("\n")
    print("Press [a,2-9] or q to quit benchmarking")
    print("The following is the end-to-end autonomous driving appications that you can launch: ")
    print("Key 2: Kalman filter (ExtendedKF)")
    print("Key 3: Path Plannung (hybrid_astar)")
    print("Key 4: Object Detection (darknet_ros)")
    print("Key 5: Fast Lidar Odometry And Mapping (floam)")
    print("Key 6: Lane Detection (cuda-lane-detection)")
    print("Key 7: Structure from Motion (openMVG)")
    print("Key 8: Lidar Tracking (lidar-tracking)")
    print("Key 9: Localization (orb-slam-3)")
    print("Key a: Launch all applications")
    data = ""

    while(True):
        data = sys.stdin.readline()
        if len(data) >= 1:
            break

    if data[0] == 'q' or data[0] == 'Q':
        print("bye")
        os.system('kill -9 -1 > /dev/null 2>&1')
        sys.exit(0)
    else:
        command_in = True
        try:
            if data[0] == 'a':
                command = data[0]
                pass
            else:
                command = int(data[0])
        except:
            command_in = False
            print("please input right command")

def preexec_function():
    os.setpgrp()

def launchBackgoundProcessWithoutOutput(full_command):
    subprocess.Popen(full_command.split(), close_fds=True, preexec_fn = preexec_function, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def launchBackgoundProcessWithOutput(full_command):
    subprocess.Popen(full_command, shell=True, close_fds=True, preexec_fn = preexec_function, stdout=sys.stdout, stderr=sys.stdout)


# 0 - 9
# a -> all commands
# 0 - roscore
# 1 - rosbag
# 2 - ekf
# 3 - hybrid-astar
# 4 - darknet_ros
# 5 - floam
# 6 - lane-detection
# 7 - SFM
# 8 - lidar-tracking
# 9 - orb-slam-3

def commandHandler(command):
    global command_in, ROOT
    os.system('clear')
    command_in = False
    turn_all = False
    if command == 'a':
        turn_all = True

    if command == 0 or turn_all:
        #roscore
        if(checkIfProcessRunning("roscore") and checkIfProcessRunning("rosmaster") and checkIfProcessRunning("rosout")):
            print("roscore is already launched")
        else:
            os.system("sudo pkill -9 roscore")
            os.system("sudo pkill -9 rosmaster")
            os.system("sudo pkill -9 rosout")
            #TODO: make env function
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/end-to-end/roscore.sh > /dev/null 2>&1 &")

    if command == 1 or turn_all:
        #rosbag
        if(checkIfProcessRunning("rosbag")):
            print("rosbag is already launched")
        else:
            os.system("sudo pkill -9 rosbag")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/end-to-end/rosbag.sh > /dev/null 2>&1 &")

    if command == 2 or turn_all:
        if(checkIfProcessRunning("ExtendedKF")):
            print("kalman filter is already launched")
        else:
            os.system("sudo pkill -9 ./ExtendedKF")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/kalman_filter/extended-kalman-filter/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_kalman_filter.sh > /dev/null 2>&1 &")
    
    if command == 3 or turn_all:
        #hybrid_astar
        if(checkIfProcessRunning("hybrid_astar") and checkIfProcessRunning("map_server") and checkIfProcessRunning("tf_broadcaster") ):
            print("hybrid_astar is already launched")
        else:
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/path_planning/hybrid-astar/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_hybrid_a_star.sh > /dev/null 2>&1 &")

    if command == 4 or turn_all:
        #darknet_ros
        if(checkIfProcessRunning("darknet_ros") and checkIfProcessRunning("map_server") and checkIfProcessRunning("tf_broadcaster") ):
            print("darknet_ros is already launched")
        else:
            #TODO : detect ROS version
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/object_detection/darknet-ros/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_darknet_ros.sh > /dev/null 2>&1 &")

    if command == 5 or turn_all:
        #floam
        if(checkIfProcessRunning("floam.launch")):
            print("floam is already launched")
        else:
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/localization/floam/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_floam.sh > /dev/null 2>&1 &")
    if command == 6 or turn_all:
        #lane-detection
        if(checkIfProcessRunning("cuda-lane-detection")):
            print("cuda-lane-detection is already launched")
        else:
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/lane_detection/cuda-lane-detection/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_cuda_lane_detection.sh > /dev/null 2>&1 &")

    if command == 7 or turn_all:
        #SFM
        if(checkIfProcessRunning("openMVG")):
            print("openMVG is already launched")
        else: 
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/structure_from_motion/open-mvg/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_openmvg.sh > /dev/null 2>&1 &")

    if command == 8 or turn_all:
        # lidar-tracking
        if(checkIfProcessRunning("kf_tracker")):
            print("lidar-tracking is already launched")
        else:
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/object_tracking/lidar-tracking/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_lidar_tracking.sh > /dev/null 2>&1 &")
 
    if command == 9 or turn_all:
        # Orb-slam-3 
        if(checkIfProcessRunning("Mono")):
            print("orb-slam-3 is already launched")
        else:  
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/localization/orb-slam-3/run_infinite.sh > /dev/null 2>&1 &")
            launchBackgoundProcessWithoutOutput("/bin/bash -c "+ROOT+"/scripts/profile/memory_wss_orb_slam_3.sh > /dev/null 2>&1 &")

def displayCurrentApps():
    result = []
    if checkIfProcessRunning("roscore"):
       result.append("roscore")

    if checkIfProcessRunning("rosbag"):
       result.append("rosbag")

    if checkIfProcessRunning("ExtendedKF"):
       result.append("ExtendedKF")

    if checkIfProcessRunning("hybrid_astar"):
       result.append("hybrid_astar")

    if checkIfProcessRunning("darknet_ros"):
       result.append("darknet_ros")

    if checkIfProcessRunning("floam"):
       result.append("floam")

    if checkIfProcessRunning("cuda-lane-detection"):
       result.append("cuda-lane-detection")

    if checkIfProcessRunning("openMVG"):
       result.append("openMVG")       

    if checkIfProcessRunning("kf_tracker"):
       result.append("lidar-tracking")

    if(checkIfProcessRunning("Mono")):
        result.append("orb-slam-3")

    print("current running list : "+','.join(result))

if __name__ == "__main__":
    ROOT = os.getcwd()+"/../../"
    signal.signal(signal.SIGINT, sigintHandler)
    
    prerun_ros_cmd = "/bin/bash -c "+ROOT+"/scripts/end-to-end/roscore.sh > /dev/null 2>&1 &"
    subprocess.Popen(prerun_ros_cmd.split(), close_fds=True, preexec_fn = preexec_function, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    prerun_ros_cmd = "/bin/bash -c "+ROOT+"/scripts/end-to-end/rosbag.sh"
    subprocess.Popen(prerun_ros_cmd.split(), close_fds=False, preexec_fn = preexec_function, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
    prelaunchcmd = sys.argv[1:]

    for cmd in prelaunchcmd:
        if cmd == 'a':
                pass
        else:
            cmd = int(cmd)
        commandHandler(cmd)

    while(1):
        time.sleep(2)
        # os.system('clear')
        # print("Use Ctrl + C to input the application you want to launch")
        # if(command_in):
        #     commandHandler(command)
        # displayCurrentApps()
        # displaySystemUtil()
        # columns, rows = os.get_terminal_size(0)
        # number_of_chars = columns-1
        # pad = int(rows/2)-2
        # print(pad*"\n")
        # print(number_of_chars*"-")
        # time.sleep(2)
