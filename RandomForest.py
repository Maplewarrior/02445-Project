import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV, StratifiedKFold

X = np.load("Data/Data For Machine Learning/data_x.npy")
y = np.load("Data/Data For Machine Learning/data_y.npy")
#%%

RF_params = {#"n_estimators": [30, 50, 70, 90, 100, 120, 140, 200], 
              "criterion": ["gini", "entropy"],
              "max_depth": [2, 10, None],
              "min_samples_split": [2, 10, 20, 25, 50],
              "max_features": ["auto", "sqrt", "log2"], 
              }
rfc = RandomForestClassifier(random_state = 123)
clf_rf = GridSearchCV(estimator = rfc, param_grid = RF_params, cv = 5, scoring = 'accuracy', verbose = 2)
clf_rf.fit(X,y)


optimal_params_rf = clf_rf.best_params_



#%%
optimal_params_rf = {'criterion': 
                     'entropy', 
                     'max_depth': 10, 
                     'max_features': 'auto', 
                     'min_samples_split': 20}



def RandomForestModel(X_train, y_train, X_test, y_test, n_trees):
    rf_classifier = RandomForestClassifier(n_trees, criterion = str(optimal_params_rf["criterion"]), 
                                           max_depth= optimal_params_rf["max_depth"], 
                                           min_samples_split = optimal_params_rf["min_samples_split"], 
                                           max_features=str(optimal_params_rf["max_features"]), 
                                           verbose=2, bootstrap = True)
    rf_classifier.fit(X_train, y_train)
    
    # Get predictions
    y_est = rf_classifier.predict(X_test)
    ErrorRateRF = (y_test!=y_est).sum(dtype=float) / len(y_test)
    
    return ErrorRateRF


# errors = list()
# CV1 = StratifiedKFold(5, shuffle= True)
# for train_index, test_index in CV1.split(X,y):
#     X_train = X[train_index]
#     X_test = X[test_index]
#     y_train = y[train_index]
#     y_test = y[test_index]
    
#     error = RandomForestModel(X_train, y_train, X_test, y_test, 1000)
    
#     errors.append(error)

# print(errors)