#1. Loop all the files and select the ones which end in (-fine_trace.csv)
#2. Extract the application name -- first part (e.g., jetson_inference)

#    3. For each application extract <avg> power_cpu_w, power_gpu_w, power_mem_w
    
#4. Create a new CSV (energy-results.csv) with Appname, <avg> power_cpu_w, <avg> power_gpu_w, <avg> power_mem_w

import sys
import os
import numpy as np
import pandas as pd
from statistics import mean

def find_files(dir) -> list:
    result = []
    for filename in os.listdir(dir):
        if filename.endswith("-fine_trace.csv"):
            result.append(str(filename))
    return [result, dir]

def process(files:list) -> list:
    output = []
    os.chdir(files[1])
    for i in files[0]:
        gpu_run_mean_list = []
        data = pd.read_csv(i,delimiter=";")
        name = i[:-15].replace("_", "-")
        gpu_raw_mean = data["power_gpu_w"].mean()
        
        if data["power_gpu_w"].max() - gpu_raw_mean > 0.1:
            for j in data["power_gpu_w"]:
                if j > gpu_raw_mean:
                    gpu_run_mean_list.append(j)

        if len(gpu_run_mean_list) != 0:
            gpu_run_mean = mean(gpu_run_mean_list)
        else:
            print(name, gpu_raw_mean)
            gpu_run_mean = gpu_raw_mean
        output.append([name, data["power_cpu_w"].mean(), gpu_run_mean ,data["power_mem_w"].mean()])
    return output

def write_file(data:list):
    col = ['ApplicationName', 'Cpu', 'Gpu', 'Mem']
    new_data = pd.DataFrame(data, columns = col)
    new_data = new_data.sort_values(by=['Cpu','Gpu', 'Mem'])
    df_1 = new_data.iloc[0:1]
    df_2 = new_data.iloc[1:]
    df_2 = df_2.sort_values(by = ['ApplicationName'])
    new_data = pd.concat([df_1, df_2])
    new_data.to_csv("energy-result.csv", index=False)


if __name__ == "__main__":
    FileList = find_files( str(sys.argv[1]) )
    DataOutput = process(FileList)
    write_file(DataOutput)
