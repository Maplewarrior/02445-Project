import numpy as np
import pandas as pd
from scipy.linalg import svd

from sklearn import tree
from sklearn.model_selection import StratifiedKFold
from sklearn.ensemble import RandomForestClassifier

df = pd.read_csv("Data/armdataPreprocessedAllLabels.csv")


data = df["data_all_exps"].to_numpy(dtype=("float64"))

y_vals = np.array([df["distances"], df["obstacles"]]).T
# Remove the last 30000 values since there are no labels
X = data[:450000]
X = X.reshape(-1,1)


# Make sure there are no NAN values
assert len(np.isnan(X)[np.isnan(X) == True]) == 0


# One-hot encoding the labels
OneHotEncodings = np.empty((15,15))
for i in range(15):
    template = np.zeros(15)
    template[i] = 1
    OneHotEncodings[i] = template
    
y = np.empty((450000, 1))



count = 30000
for i in range(15):
    y[(count-30000):count,:] = i
    count += 30000


# Labels = {str(OneHotEncodings[0]): "d = 15 and S",
#           str(OneHotEncodings[1]): "d = 15 and M",
#           str(OneHotEncodings[2]): "d = 15 and T",
          
#           str(OneHotEncodings[3]): "d = 22.5 and S",
#           str(OneHotEncodings[4]): "d = 22.5 and M",
#           str(OneHotEncodings[5]): "d = 22.5 and T",
          
#           str(OneHotEncodings[6]): "d = 30 and S",
#           str(OneHotEncodings[7]): "d = 30 and M",
#           str(OneHotEncodings[8]): "d = 30 and T",
          
#           str(OneHotEncodings[9]): "d = 37.5 and S",
#           str(OneHotEncodings[10]): "d = 37.5 and M",
#           str(OneHotEncodings[11]): "d = 37.5 and T",
          
#           str(OneHotEncodings[12]): "d = 45 and S",
#           str(OneHotEncodings[13]): "d = 45 and M",
#           str(OneHotEncodings[14]): "d = 45 and T",
#     }
Labels = {0: "d = 15 and S",
          1: "d = 15 and M",
          2: "d = 15 and T",
          
          3: "d = 22.5 and S",
          4: "d = 22.5 and M",
          5: "d = 22.5 and T",
          
          6: "d = 30 and S",
          7: "d = 30 and M",
          8: "d = 30 and T",
          
          9: "d = 37.5 and S",
          10: "d = 37.5 and M",
          11: "d = 37.5 and T",
          
          12: "d = 45 and S",
          13: "d = 45 and M",
          14: "d = 45 and T",
    }

#%%
def subtractMean(X):
    N = np.shape(X)[0]
    return X - np.ones((N, 1)) * X.mean(axis=0)


def divideByStdDev(X):
    return X / np.std(X,axis=0)


def computeSVD(X):
    return svd(X, full_matrices=False)


def computePCAExplainedVariance(S):
    return (S * S) / (S * S).sum()



# X = data matrix and rho = threshold for explained variance
# def getVMatrix(X, rho):
#     # Compute singular values
#     U, S, V = computeSVD(X)
#     V = V.T
    
#     exp_var = computePCAExplainedVariance(S)
#     i = 0
#     num_pcs = exp_var[i]
#     while num_pcs < rho:
#         num_pcs += exp_var[i]
#         i+=1
#     #X_pca = X @ V[:,:i]
#     return V[:,:i]  

def getVMatrix(X, i):
    # Compute singular values
    U, S, V = computeSVD(X)
    V = V.T
    return V[:,:i]

def projectData(data, V):
    return data @ V


X = subtractMean(X)


#%%
K1 = 2
K2 = 5



CV1 = StratifiedKFold(K1, shuffle = True)
CV2 =  StratifiedKFold(K2, shuffle = True)

errors = list()

# Create smaller datasets for faster run time while debugging
# X = X[:90000]
# y = y[:90000]
y = y.squeeze()




# Set hyperparameters
lambdas = np.power(10.,range(-6,6))
T = np.arange(5,15,1)


# Predefining variables
val_errors_rf = np.empty((len(T),K2))
val_errors_LogReg = np.empty((len(lambdas), K2))

gen_errors_rf = np.empty((K1, 1))
gen_errors_LogReg = np.empty((K1, 1))



k = 0
for train_index, test_index in CV1.split(X, y):
    
    X_par = X[train_index]
    y_par = y[train_index]
    X_test = X[test_index]
    y_test = y[test_index]
    
    # PCA on train
    X_par = subtractMean(X_par)
    X_par = divideByStdDev(X_par)
    V_train = getVMatrix(X_par, 9)
    X_par = projectData(X_par, V_train)
    
    # PCA on test
    X_test = subtractMean(X_test)
    X_test = divideByStdDev(X_test)
    V_test = getVMatrix(X_test, 9)
    X_test = projectData(X_test, V_test)
    
    c = 0 
    for train_index, test_index in CV2.split(X_par, y_par):
        X_train = X[train_index]
        y_train = y[train_index]
        X_val = X[test_index]
        y_val = y[test_index]
        
           
        for index, t in enumerate(T):
             rf_classifier = RandomForestClassifier(t)
             rf_classifier.fit(X_train, y_train)
             y_est = rf_classifier.predict(X_val)
        
             ErrorRate = (y_val!=y_est).sum(dtype=float) / len(y_val)
             
             val_errors_rf[index, c] = ErrorRate
        
        # for i, l in enumerate(lambdas):
            #...
            #...
        
        if c == K2-1: 
            # Find the index where the validation error is lowest amongst all 10 splits
            opt_T_index = np.where(np.mean(val_errors_rf, axis = 1) == min(np.mean(val_errors_rf, axis = 1)))
            opt_T_index = int(opt_T_index[0])
            opt_T = T[opt_T_index]    
        
        c+= 1
    
    # Train models on X_par, y_par and predict on X_test
    
    rf_classifier = RandomForestClassifier(opt_T)
    rf_classifier.fit(X_par, y_par)
    y_est = rf_classifier.predict(X_test)
    
    rf_gen_err = (y_test!=y_est).sum(dtype=float) / len(y_test)
    gen_errors_rf[k] = rf_gen_err
    k+= 1
    
             
        
    

#%%
print(gen_errors_rf)
# print(val_errors_rf)

# values = np.array([[1,2,3,4],
#           [1,2,3,4],
#           [0,0,1,1],
#           [4,5,6,4],
#           [9,1,9,4]])

# opt_index = np.where(np.mean(values, axis = 0) == min(np.mean(values, axis = 0)))
# opt_index = int(opt_index[0])
# # print(opt_index)

# # print(np.mean(values[0,:]))
# # print((1+2+3+4)/4)

# for i in range(5):
#     print(np.mean(values[i]))
# print(np.mean(values,axis=1))
