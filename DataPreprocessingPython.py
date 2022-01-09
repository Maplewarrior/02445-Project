# Python data processing
import numpy as np
import os


path = 'C:/Users/micha/OneDrive/Skrivebord/02445-Project/Data'
os.chdir(path)


armdata = np.load("armdata.npy")


# Removing NaN's from the data
# print(len(armdata[0][0][0][:,0]))
nan_values = np.isnan(armdata)
num_nans = len(nan_values[nan_values == True])

nan_indexes = np.where(nan_values == True)


# Function that check if a value is a NaN.
def isNaN(value):
    if value == value:
        return True
    else:
        return False
# If a value is a NaN, the function returns false. 


print(type(armdata[4][8][0][0][0]))
print(armdata[4][8][0][0][0])
# armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]]
#     [nan_indexes[3][i]][nan_indexes[4][i]]



for i in range(num_nans):
    above = False
    below = False
    # Check if the value below is a NaN
    if isNaN(armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i+1][nan_indexes[4][i]]) == True:
        below = True
    
    # Check if the coordinate is the first coordinate
    if nan_indexes[3][i] != 0:
        # Check if the value above is a NaN
        if isNaN(armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i-1][nan_indexes[4][i]]) == True:
            above = True
    
    if above == True and below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = (armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i+1][nan_indexes[4][i]] +  armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i-1][nan_indexes[4][i]]) / 2
    elif above == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i-1][nan_indexes[4][i]]
                                                                  
    elif below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i+1][nan_indexes[4][i]]
        
#%%
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
        
#%%

if len(np.isnan(armdata)[np.isnan(armdata) == True]) > 0:
    print("fuck")
else: 
    print("business is booming")

cur_idx = [nan_indexes[0][0]],[nan_indexes[1][0]],[nan_indexes[2][0]],[nan_indexes[3][0]],[nan_indexes[4][0]]
print(cur_idx)

print(float(armdata[cur_idx]))




    