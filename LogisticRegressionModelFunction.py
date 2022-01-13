from sklearn.linear_model import LogisticRegression


def LogisticRegressionModel(X_train,X_test,y_train,y_test,lambda_value):
    
    c = 1/lambda_value
    logistc_model = LogisticRegression(random_state=0, max_iter = 100000,penalty='l2',C=c)
    logistc_model.fit(X_train,y_train)
    
    pred = logistc_model.predict(X_test)
    
    true = 0
    total = len(pred)
    for i in range(len(pred)):
        if pred[i] == y_test[i]:
            true += 1
    
    error = 1-(true/total)
    
    return error