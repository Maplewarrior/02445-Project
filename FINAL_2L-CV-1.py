import numpy as np
import pandas as pd
from scipy.linalg import svd

from sklearn import tree
from sklearn.model_selection import StratifiedKFold, GridSearchCV

from NeuralNetworkModelFunction import *
from LogisticRegressionModelFunction import *
from sklearn.decomposition import PCA
from RandomForest import * 
#%%

X = np.load("Data/Data For Machine Learning/data_x_xz.npy")
# X = np.load("Data/Data For Machine Learning/data_x.npy")
# X = np.load("Data/Data For Machine Learning/data_x_yz.npy")
y = np.load("Data/Data For Machine Learning/data_y.npy")


# Make sure there are no NAN values
assert len(np.isnan(X)[np.isnan(X) == True]) == 0

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

# Functions for PCA
def subtractMean(X):
    N = np.shape(X)[0]
    return X - np.ones((N, 1)) * X.mean(axis=0)


def divideByStdDev(X):
    return X / np.std(X,axis=0)


def computeSVD(X):
    return svd(X, full_matrices=False)


def computePCAExplainedVariance(S):
    return (S * S) / (S * S).sum()

def getVMatrix(X, i):
    # Compute singular values
    U, S, V = computeSVD(X)
    V = V.T
    return V[:,:i]

def projectData(data, V):
    return data @ V



#%%

K1 = 10
K2 = 10

CV1 = StratifiedKFold(K1, shuffle = True)
CV2 =  StratifiedKFold(K2, shuffle = True)

y = y.squeeze()


# Set hyperparameters
lambdas = np.power(10.,range(-8,2))
T = np.arange(75,825, 75)
hiddenLayers = np.arange(1,12,1)
#%%
optimal_trees = list()
optimal_lambdas = list()
optimal_hidden_layers = list()

# Predefining variables
val_errors_rf = np.empty((len(T),K2))
val_errors_LogReg = np.empty((len(lambdas), K2))
val_errors_ANN = np.empty((len(hiddenLayers),K2))



gen_errors_rf = np.empty((K1, 1))
gen_errors_LogReg = np.empty((K1, 1))
gen_errors_ANN = np.empty((K1, 1))


final_E_gen_RF = np.empty((K1, 1))
final_E_gen_LogReg = np.empty((K1, 1))
final_E_gen_ANN = np.empty((K1, 1))




E_gen_vals_RF = np.empty((K1,3))
E_gen_vals_ANN = np.empty((K1,3))
E_gen_vals_log_reg = np.empty((K1,3))


#%%

################################ FOR (x,z) DATA !!!! PC's = 8
################################ FOR (x,y) DATA PC's = 7
################################ FOR (y,z) DATA PC's = 2
################################ FOR (x,y,z) DATA PC's = 9



k = 0
for train_index, test_index in CV1.split(X, y):
    
    X_par = X[train_index]
    y_par = y[train_index]
    X_test = X[test_index]
    y_test = y[test_index]
    
    
    pca = PCA(n_components = 8)
    pca.fit(X_par)
    
    X_par = pca.transform(X_par)
    X_test = pca.transform(X_test)
    
    
    # print("Outer dimensions:", X_par.shape)
    
    c = 0 
    for train_index, test_index in CV2.split(X_par, y_par):
        X_train = X_par[train_index]
        y_train = y_par[train_index]
        X_val = X_par[test_index]
        y_val = y_par[test_index]
        # print("Inner dimensions:", X_train.shape)
        
        print("number of inner folds: ", c, "number of outer folds:", k)
        
           
        for index, t in enumerate(T):
        
             ErrorRateRF = RandomForestModel(X_train, y_train, X_val, y_val, t)
             val_errors_rf[index, c] = ErrorRateRF
             
        for index, h in enumerate(hiddenLayers):
             ErrorRateANN = NeuralNetworkModel(X_train,X_val, y_train, y_val, h)
             val_errors_ANN[index, c] = ErrorRateANN
             
        for index, l in enumerate(lambdas):
             ErrorRateLogReg = LogisticRegressionModel(X_train,X_val, y_train,y_val,l)
             val_errors_LogReg[index, c] = ErrorRateLogReg
            
            
        if c == K2-1: 
            # Optimal number of trees
            opt_T_index = np.where(np.mean(val_errors_rf, axis = 1) == min(np.mean(val_errors_rf, axis = 1)))[0][0]
            if not type(opt_T_index) == np.int64:
                opt_T_index = int(opt_T_index[0])
            else:
                opt_T_index = int(opt_T_index)
            opt_T = T[opt_T_index]
            optimal_trees.append(opt_T)
            
            # Optimal hidden layers
            opt_h_index = np.where(np.mean(val_errors_ANN, axis = 1) == min(np.mean(val_errors_ANN, axis = 1)))[0][0]
            if not type(opt_h_index) == np.int64:
                opt_h_index = int(opt_h_index[0])
            else:
                opt_h_index = int(opt_h_index)
            opt_h = hiddenLayers[opt_h_index]
            optimal_hidden_layers.append(opt_h)
            
            # Optimal regularization term
            opt_lambda_index = np.where(np.mean(val_errors_LogReg, axis = 1) == min(np.mean(val_errors_LogReg, axis = 1)))[0][0]
            if not type(opt_lambda_index) == np.int64:
                opt_lambda_index = int(opt_lambda_index[0])
            else:
                opt_lambda_index = int(opt_lambda_index)
            opt_lambda = lambdas[opt_lambda_index]    
            optimal_lambdas.append(opt_lambda)
        c+= 1
    
    
    # Estimate generalization error for the s models in the inner fold
    gen_errors_rf[k] = ((X_val.shape[0] / X_par.shape[0]) * np.mean(val_errors_rf[k,:])).sum(dtype = float)
    gen_errors_LogReg[k] = ((X_val.shape[0] / X_par.shape[0]) * np.mean(val_errors_LogReg[k,:])).sum(dtype = float)
    gen_errors_ANN[k] = (X_val.shape[0] / X_par.shape[0] * np.mean(val_errors_ANN[k,:])).sum(dtype = float)
    
    
    # Train the models using optimal parameters
    ErrorRateRF = RandomForestModel(X_par, y_par, X_test, y_test, opt_T)
    
    final_E_gen_RF[k] = ErrorRateRF
    
    ErrorRateANN = NeuralNetworkModel(X_par,X_test, y_par, y_test, opt_h)
    final_E_gen_ANN[k] = ErrorRateANN
    
    ErrorRateLogReg = LogisticRegressionModel(X_par,X_test, y_par, y_test, opt_lambda)
    final_E_gen_LogReg[k] = ErrorRateLogReg
    
               
    k+= 1

    
    
    
print("RF final: ", final_E_gen_RF)
print("ANN final: ", final_E_gen_ANN)
print("LogReg final: ", final_E_gen_LogReg)





