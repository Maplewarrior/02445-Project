""""
Script for loading .RData into python, removing NaN's and saving it 
as a .npy file. 
"""

import numpy as np
import pandas as pd
from rpy2.robjects import pandas2ri, r, numpy2ri

pandas2ri.activate()
path = 'C:/Users/micha/OneDrive/Skrivebord/02445-Project/Data/armdata.rdata'
robj = r.load(path)
armdata = np.array(r['armdata'])




nan_values = np.isnan(armdata)
num_nans = len(nan_values[nan_values == True])

nan_indexes = np.where(nan_values == True)

# Function that check if a value is a NaN.
def isNaN(value):
    if value == value:
        return True
    else:
        return False

# Remove NaN values
for i in range(num_nans):
    above = False
    below = False
    below_value = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i+1][nan_indexes[4][i]]
    above_value = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i-1][nan_indexes[4][i]]
    
    
    # Check if the value below is a NaN
    if isNaN(below_value) == True:
        below = True
    
    # Check if the coordinate is the first coordinate
    if nan_indexes[3][i] != 0:
        # Check if the value above is a NaN
        if isNaN(above_value) == True:
            above = True
    
    if above == True and below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = (above_value + below_value)/2
    elif above == True:
       armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = above_value
                                                                  
    elif below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = below_value

if len(np.isnan(armdata)[np.isnan(armdata) == True]) > 0:
    print("NaN values found")
else: 
    print("No NaN values found")


# Save the preprocessed data as a .npy file
np.save("armdataPreprocessed", armdata)