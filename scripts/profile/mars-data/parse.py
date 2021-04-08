import sys
import os
import numpy as np
import pandas as pd
from statistics import mean

# Please adjust if applications are misclassified
POWER_CLASSIFY_MARGIN=0.2

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
        data = pd.read_csv(i,delimiter=";")
        name = i[:-15].replace("_", "-")

        gpu_power_mean = data["power_gpu_w"].mean()
        
        diff = data["power_gpu_w"].max() - gpu_power_mean
        # Debug print what is the difference
        # print(diff)

        # Check if GPU App
        if diff > POWER_CLASSIFY_MARGIN:
            print ("[GPU] ", end='')
            data = data[data['power_gpu_w']>gpu_power_mean]
        else:
            print ("[CPU] ", end='')

        print (name, "processed")

        output.append([name, data["power_cpu_w"].mean(), data["power_gpu_w"].mean() ,data["power_mem_w"].mean()])
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
