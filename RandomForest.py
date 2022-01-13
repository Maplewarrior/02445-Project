# Random forest classifier
import numpy as np
import pandas as pd

from sklearn import tree
from sklearn.model_selection import StratifiedKFold

df = pd.read_csv("Data/armdataPreprocessedAllLabels.csv")


data = df["data_all_exps"].to_numpy(dtype=("float64"))

labels = np.array([df["distances"], df["obstacles"]]).T
# Remove the last 30000 values since there are no labels
X = data[:450000]
X = X.reshape(-1,1)

# Make sure there are no NAN values
assert len(np.isnan(X)[np.isnan(X) == True]) == 0



OneHotEncodings = np.empty((15,1))
for i in range(15):
    template = np.zeros(15)
    template[i] = 1
    OneHotEncodings[i,0] = template
    

#%%
K1 = 10
K2 = 10

CV1 = StratifiedKFold(K1, shuffle = True)
CV2 =  StratifiedKFold(K2, shuffle = True)

max_depths = np.arange(6,11,1)
# print(len(max_depths))


final_preds = np.zeros(10)


# %%
k = 0
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
    
        dtc = tree.DecisionTreeClassifier(max_depth = max_depths[c], max_features= "sqrt", splitter = "best", random_state=42)
        dtc.fit(X_train, y_train)
        y_pred = dtc.predict(X_val)
        
        count = 0
        # Calculate scores
        for i in range(len(y_pred)):
            count_inner = 0
            for j in range(10):
                if y_pred[i][j] == y_val[i][j]:
                    count_inner += 1
            if count_inner == 10:
                count += 1
                    
        acc = (count/len(y_val))*100
        scores.append(acc)
        
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
