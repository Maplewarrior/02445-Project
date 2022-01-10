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
def isNotNaN(value):
    if value == value:
        return True
    else:
        return False
# If a value is a NaN, the function returns false. 


# print(type(armdata[4][8][0][0][0]))

#%%

print(armdata[0][0][0][99][0])

print(nan_indexes[0][6], nan_indexes[1][6], nan_indexes[2][6], nan_indexes[4][6],nan_indexes[3][6])
print(nan_indexes[0][7], nan_indexes[1][7], nan_indexes[2][7], nan_indexes[4][7],nan_indexes[3][7])

#%%
print(armdata[9][8][0][0][0])
print(armdata[9][8][0][0][1])
print(armdata[9][8][0][0][2])
print(armdata[9][8][0][3][0])
#%%
print(armdata[9][8][0][0][0])
print(armdata[9][8][0][1][0])
print(armdata[9][8][0][2][0])



#%%
for i in range(num_nans):
    
    above = False
    below = False
    col = nan_indexes[4][i]
    
    below_value = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i+1][col]
    above_value = armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][i-1][col]
    
    
    # Check if the value below is not a NaN
    if isNotNaN(below_value) == True:
        below = True
    
    # Check if the coordinate is the first coordinate
    if nan_indexes[3][i] != 0:
        # Check if the value above is not a NaN
        if isNotNaN(above_value) == True:
            above = True
    
    if above == True and below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = (above_value + below_value)/2
    elif above == True:
       armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = above_value
                                                                  
    elif below == True:
        armdata[nan_indexes[0][i]][nan_indexes[1][i]][nan_indexes[2][i]][nan_indexes[3][i]][nan_indexes[4][i]] = below_value
        
#%%
nan_values = np.isnan(armdata)
new_nan_indexes = np.where(nan_values == True)



#%%
if len(np.isnan(armdata)[np.isnan(armdata) == True]) > 0:
    print("fuck")
else: 
    print("business is booming")

cur_idx = [nan_indexes[0][0]],[nan_indexes[1][0]],[nan_indexes[2][0]],[nan_indexes[3][0]],[nan_indexes[4][0]]
print(cur_idx)

print(float(armdata[cur_idx]))




    