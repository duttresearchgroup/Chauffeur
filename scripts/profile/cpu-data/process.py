import sys
import os
import numpy as np
import pandas as pd
from statistics import mean

def file_check(dir):
    if "px2_ipc.csv" in os.listdir(dir) and "tx2_ipc.csv" in os.listdir(dir):
        return dir
    print("px2_ipc.csv/tx2_ipc.csv not in given pass")
    return False

def process(passed):
    if passed != False:
        os.chdir(passed)

        tx2_data = pd.read_csv('tx2_ipc.csv',delimiter=",")
        px2_data = pd.read_csv('px2_ipc.csv',delimiter=",")
              
        tx2_data = tx2_data.drop(columns = ["2","3","4","5"], axis=1)
        px2_data = px2_data.drop(columns = ["2","3","4","5"], axis=1)

        tx2_data = tx2_data.rename(columns = {"1":"tx2-1", "6": "tx2-6"})
        px2_data = px2_data.rename(columns = {"1":"px2-1", "6": "px2-6"})

        new_data = tx2_data.merge(px2_data)
        new_data = new_data.sort_values(by=['ApplicationName'])
        new_data.to_csv("cpu-result.csv", index=False)

    return 0


if __name__ == "__main__":
    dir = file_check( str(sys.argv[1]) )
    process(dir)
    #write_file(DataOutput)
