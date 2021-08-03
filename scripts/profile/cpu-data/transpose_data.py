import sys
import os
import numpy as np
import pandas as pd
from statistics import mean


if __name__ == "__main__":
    tx2_data = pd.read_csv('tx2_executiontime.csv',delimiter=",", index_col = 0)
    px2_data = pd.read_csv('px2_executiontime.csv',delimiter=",", index_col = 0)

    tx2_data = tx2_data.sort_values(by=['ApplicationName'])
    px2_data = px2_data.sort_values(by=['ApplicationName'])

    tx2_data = tx2_data.transpose()
    px2_data = px2_data.transpose()

    tx2_data = tx2_data.reset_index()
    px2_data = px2_data.reset_index()

    tx2_data.to_csv("tx2-executiontime-t.csv", index = False)
    px2_data.to_csv("px2-executiontime-t.csv", index = False)