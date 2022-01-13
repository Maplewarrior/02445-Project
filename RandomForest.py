from sklearn.ensemble import RandomForestClassifier



def RandomForestModel(X_train, y_train, X_test, y_test, n_trees):
    rf_classifier = RandomForestClassifier(n_trees, verbose=1, bootstrap = True)
    rf_classifier.fit(X_train, y_train)
    
    # Get predictions
    y_est = rf_classifier.predict(X_test)
    ErrorRateRF = (y_test!=y_est).sum(dtype=float) / len(y_test)
    
    return ErrorRateRF
