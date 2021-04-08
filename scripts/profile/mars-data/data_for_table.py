
import sys
import os
import numpy as np
import pandas as pd
from statistics import mean
from scipy import stats

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
        # Check if GPU App
        diff = data["power_gpu_w"].max() - gpu_power_mean
        # Debug print what is the difference
        # print(diff)
        if diff > POWER_CLASSIFY_MARGIN:
            print ("[GPU] ", end='')
            # Trim GPU apps to remove initialization
            data = data[data['power_gpu_w']>gpu_power_mean]
        else:
            print ("[CPU] ", end='')

        print(name)

        df_mem = data["total_mem_access"]
        df_llc = data["total_llc_misses"]

        df_mem = df_mem[ df_mem.between(df_mem.quantile(0), df_mem.quantile(0.99)) ]
        df_llc = df_llc[ df_llc.between(df_llc.quantile(0), df_llc.quantile(0.99)) ]


        temp = [name, df_mem.mean(), df_mem.max(),  df_llc.mean(), df_llc.max()]
        
        for index in range(1,5):
            temp[index] = int( (temp[index]*20)/(10**6))
        output.append(temp)
    
    return output



def write_file(data:list):
    col = ['ApplicationName', 'AvgTotalMemAccess', 'PeakTotalMemAccess', 'AvgTotalLlcMisses', 'PeakTotalLlcMisses']
    new_data = pd.DataFrame(data, columns = col)
    new_data = new_data.sort_values(by=['PeakTotalMemAccess','PeakTotalLlcMisses', 'AvgTotalMemAccess', 'AvgTotalLlcMisses'])
    df_1 = new_data.iloc[0:1]
    df_2 = new_data.iloc[1:]   
    df_2 = df_2.sort_values(by = ['ApplicationName'])
    new_data = pd.concat([df_1, df_2])
    new_data.to_csv("mem-llc.csv", index=False)

    data = pd.read_csv("mem-llc.csv",delimiter=",", index_col = 0)
    data = data.transpose()
    data = data.reset_index()
    data.to_csv("mem-llc.csv", index=False)




if __name__ == "__main__":
    FileList = find_files( str(sys.argv[1]) )
    DataOutput = process(FileList)
    write_file(DataOutput)
