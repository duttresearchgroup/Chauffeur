# Script for FIG.9  Main-memory access pattern of selected Chauffeur applications from CPU cores. 
# Applications demonstrate memory accesse phases (CUDA-LANE-DETECTION, DARKNET-ROS, LANENET-LANE-DETECTION)

import sys
import os
import numpy as np
import pandas as pd
from statistics import mean

access_pattern_apps = ['cuda-lane-detection', 'darknet_ros', 'lanenet-lane-detection']
access_pattern_code = ['CDL', 'DR', 'LN']

# Please adjust if applications are misclassified
POWER_CLASSIFY_MARGIN=0.2

def filter(name, data):
    gpu_power_mean = data["power_gpu_w"].mean()
    cpu_power_mean = data["power_cpu_w"].mean()
    
    diff_GPU = data["power_gpu_w"].max() - gpu_power_mean

    # Check if GPU App
    if diff_GPU > POWER_CLASSIFY_MARGIN:
        print ("[GPU] ", end='')
        tmp = data.loc[abs(data['power_gpu_w'] > gpu_power_mean)]
        data = data[data['sample_id']>=tmp.sample_id.min()]
        data = data[data['sample_id']<=tmp.sample_id.max()]
        print ("Cutoff: ",gpu_power_mean, ", Min : ", tmp.sample_id.min(), ", Max : ", tmp.sample_id.max(),)
    else:
        print ("[CPU] ", end='')
        
        # These applications have an initialization phase
        if (name == 'lidar-tracking' or name == 'orb-slam-3' ):
            # The following logic tries to discount the init phase when
            # calculating the mean
            cpu_power_mean=cpu_power_mean+1
            tmp = data.loc[abs(data['power_cpu_w'] > cpu_power_mean)]
            data = data[data['sample_id']>=tmp.sample_id.min()]
            data = data[data['sample_id']<=tmp.sample_id.max()]
            # print ("Cutoff: ",cpu_power_mean, ", Min : ", tmp.sample_id.min(), ", Max : ", tmp.sample_id.max(),)

    return data

def file_check(dir):
    if "cuda-lane-detection-fine_trace.csv" in os.listdir(dir) and "darknet_ros-fine_trace.csv" in os.listdir(dir) and "lanenet-lane-detection-fine_trace.csv" in os.listdir(dir):
        return dir
    print("cuda-lane-detection-fine_trace.csv/darknet_ros-fine_trace.csv/lanenet-lane-detection-fine_trace not in given pass")
    return False

def process(passed):
    if passed != False:
        os.chdir(passed)

        for index, name in enumerate(access_pattern_apps):
            df = pd.read_csv(name+'-fine_trace.csv',delimiter=";")
            df=filter(name, df)

            df = df.rename(columns={"total_llc_misses":"total-llc-misses"})
            df["total-llc-misses"] = (df["total-llc-misses"]*20) / (10**6)
            df["timestamp"] = df["timestamp"] - df["timestamp"].min()
            df["timestamp"] = df["timestamp"].map(lambda x: '%.2f' % x)
            df.to_csv("processed-"+access_pattern_code[index]+".csv", index=False)

            print (name, "processed")

    return 0


if __name__ == "__main__":
    dir = file_check( str(sys.argv[1]) )
    process(dir)
    #write_file(DataOutput)
