
import sys
import os
import numpy as np
import pandas as pd
from statistics import mean
from scipy import stats

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
        mem_run_mean_list = []
        llc_run_mean_list = []
        mem_run_mean = 0
        llc_run_mean = 0
        data = pd.read_csv(i,delimiter=";")
        name = i[:-15].replace("_", "-")

        df_mem = data["total_mem_access"]
        df_llc = data["total_llc_misses"]

        df_mem = df_mem[ df_mem.between(df_mem.quantile(0), df_mem.quantile(0.99)) ]
        df_llc = df_llc[ df_llc.between(df_llc.quantile(0), df_llc.quantile(0.99)) ]

        mem_raw_mean = df_mem.mean()
        llc_raw_mean = df_llc.mean()
        gpu_raw_mean = data["power_gpu_w"].mean()
        print(name, gpu_raw_mean)



        for j in df_mem:
            if j > mem_raw_mean:
                mem_run_mean_list.append(j)


        for k in df_llc:
            if k > llc_raw_mean:
                llc_run_mean_list.append(k)
        
        if len(mem_run_mean_list) != 0:
            mem_run_mean = mean(mem_run_mean_list)
        else:
            mem_run_mean = mem_raw_mean
        
        if len(llc_run_mean_list) != 0:
            llc_run_mean = mean(llc_run_mean_list)
        else:
            llc_run_mean = llc_raw_mean

        temp = [name, mem_run_mean, df_mem.max(), llc_run_mean, df_llc.max()]
        
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
