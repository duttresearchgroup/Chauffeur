import sys
import os
import numpy as np
import pandas as pd
from statistics import mean

def file_check(dir):
    if "cuda-lane-detection-fine_trace.csv" in os.listdir(dir) and "darknet_ros-fine_trace.csv" in os.listdir(dir) and "lanenet-lane-detection-fine_trace.csv" in os.listdir(dir):
        return dir
    print("cuda-lane-detection-fine_trace.csv/darknet_ros-fine_trace.csv/lanenet-lane-detection-fine_trace not in given pass")
    return False

def process(passed):
    if passed != False:
        os.chdir(passed)

        dfc = pd.read_csv('cuda-lane-detection-fine_trace.csv',delimiter=";")
        dfd = pd.read_csv('darknet_ros-fine_trace.csv',delimiter=";")
        dfl = pd.read_csv('lanenet-lane-detection-fine_trace.csv',delimiter=";")
              
        dfc = dfc.rename(columns={"total_llc_misses":"total-llc-misses"})
        dfd = dfd.rename(columns={"total_llc_misses":"total-llc-misses"})
        dfl = dfl.rename(columns={"total_llc_misses":"total-llc-misses"})

        dfc["total-llc-misses"] = (dfc["total-llc-misses"]*20) / (10**6)
        dfd["total-llc-misses"] = (dfd["total-llc-misses"]*20) / (10**6)
        dfl["total-llc-misses"] = (dfl["total-llc-misses"]*20) / (10**6)

        
        dfc["timestamp"] = dfc["timestamp"] - dfc["timestamp"].min()
        dfd["timestamp"] = dfd["timestamp"] - dfd["timestamp"].min()
        dfl["timestamp"] = dfl["timestamp"] - dfl["timestamp"].min()


        dfc.to_csv("processed-CDL.csv", index=False)
        dfd.to_csv("processed-DR.csv", index=False)
        dfl.to_csv("processed-LN.csv", index=False)        

    return 0


if __name__ == "__main__":
    dir = file_check( str(sys.argv[1]) )
    process(dir)
    #write_file(DataOutput)
