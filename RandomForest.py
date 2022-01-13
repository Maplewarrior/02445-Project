# Random forest classifier
import numpy as np
import pandas as pd

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
K1 = 10
K2 = 10

CV1 = StratifiedKFold(K1, shuffle = True)
CV2 =  StratifiedKFold(K2, shuffle = True)

max_depths = np.arange(6,11,1)
# print(len(max_depths))


final_preds = np.zeros(10)

T = np.arange(10,1000,100)
# %%
k = 0
error = list()


for train_index, test_index in CV1.split(X,y):
    X_par = X[train_index]
    y_par = y[train_index]
    x_test = X[test_index]
    y_test = y[test_index]
    
    c = 0 
    
    predictions = list()
    scores = list()
    
    for train_index, test_index in CV2.split(X_par, y_par):
        X_train = X[train_index]
        y_train = y[train_index]
        X_val = X[test_index]
        y_val = y[test_index]
        # Fit decision tree classifier
    
    
        rf_classifier = RandomForestClassifier(T[c])
        rf_classifier.fit(X_train, y_train)
        y_est = rf_classifier.predict(X_val)
        
        ErrorRate = (y_val!=y_est).sum(dtype=float) / len(y_val)
        #print('Error rate: {:.2f}%'.format(ErrorRate*100))    
        error.append(ErrorRate)
        
        if c == K2-1:
            optimal_T_index = np.where()
        c += 1
        
#%%
print(scores)

# clf = tree.DecisionTreeClassifier(max_features= "sqrt", splitter = "best", random_state=42)
# for subset in range(0, n_splits):
#     clf.fit(X_subsets[subset], y_subsets[subset])
#     # make predictions
#     y_pred = clf.predict(X_test)
    
#     # evaluate accuracy and score
#     scores.append(accuracy_score(y_test, y_pred))

# print("Max accuracy: {:.2f}%.".format(max(scores) * 100))
# print("Min accuracy: {:.2f}%.".format(min(scores) * 100))
# print("Average accuracy: {:.2f}%.".format(np.mean(scores) * 100))
# print("Std of accuracy: {:.2f}.".format(np.std(scores) * 100))
# K = 10 fold cross validation
# K1 = 10 
# K2 = 10



#%%
print(len(y_pred))
