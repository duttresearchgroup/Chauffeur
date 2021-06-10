### Script for Fig.10 Energy breakdown for Jetson TX2 using onboard I2C power sensors ###


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
        cpu_power_mean = data["power_cpu_w"].mean()
        
        diff = data["power_gpu_w"].max() - gpu_power_mean
        # Debug print what is the difference
        # print(diff)

        # Check if GPU App
        if diff > POWER_CLASSIFY_MARGIN:
            print ("[GPU] ", end='')
            tmp = data.loc[abs(data['power_gpu_w'] > gpu_power_mean)]
            data = data[data['sample_id']>tmp.sample_id.min()]
            data = data[data['sample_id']<tmp.sample_id.max()]

            data = data[data['power_gpu_w']>gpu_power_mean]
        else:
            print ("[CPU] ", end='')
            
            # These applications have an initialization phase
            if (name == 'lidar-tracking' or name == 'orb-slam-3' ):
                # The following logic tries to discount the init phase when
                # calculating the mean
                cpu_power_mean=cpu_power_mean+1
                tmp = data.loc[abs(data['power_cpu_w'] > cpu_power_mean)]
                data = data[data['sample_id']>tmp.sample_id.min()]
                data = data[data['sample_id']<tmp.sample_id.max()]
                # print ("Cutoff: ",cpu_power_mean, ", Min : ", tmp.sample_id.min(), ", Max : ", tmp.sample_id.max(),)

        print (name, "processed")

        output.append([name, data["power_cpu_w"].mean(), data["power_gpu_w"].mean() ,data["power_mem_w"].mean()])

        for j in data.columns:
            temp = j.replace("_","-")
            data = data.rename(columns={j:temp})

        data["total-llc-misses"] = (data["total-llc-misses"]*20) / (10**6)

        # data.to_csv(name+"-pg.csv",index=False, header=True )
    return output

def write_file(data:list):
    col = ['ApplicationName', 'Cpu', 'Gpu', 'Mem']
    new_data = pd.DataFrame(data, columns = col)
    new_data = new_data.sort_values(by=['Cpu','Gpu', 'Mem'])
    df_1 = new_data.iloc[0:1]
    df_2 = new_data.iloc[1:]
    df_2 = df_2.sort_values(by = ['ApplicationName'])
    new_data = pd.concat([df_1, df_2])
    new_data.to_csv("energy-result.csv", index=False, float_format='%.3f')

if __name__ == "__main__":
    FileList = find_files( str(sys.argv[1]) )
    DataOutput = process(FileList)
    write_file(DataOutput)
