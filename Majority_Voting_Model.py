from sklearn.model_selection import train_test_split
import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, models, Sequential
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier

data_x = np.load("Data/Data For Machine Learning/data_x.npy")
data_y = np.load("Data/Data For Machine Learning/data_y.npy")

X_train, X_test, y_train, y_test = train_test_split(data_x, data_y, test_size=0.3, random_state=40)


def Majority_Voting_Model(X_train,X_test,y_train,y_test):
    
    model = models.Sequential()
    for i in range(5):
        model.add(layers.Dense(16, activation='relu'))
    model.add(layers.Dense(15, activation='softmax'))
    model.compile(loss=tf.keras.losses.SparseCategoricalCrossentropy(), optimizer='adam', metrics=['accuracy'])
    model.fit(X_train, y_train, batch_size = 32, epochs=150, validation_data=(X_test, y_test))
    predictions_ANN = np.array(model.predict(X_test))
    
    c = 1/100
    logistc_model = LogisticRegression(random_state=0, max_iter = 100000,penalty='l2',C=c)
    logistc_model.fit(X_train,y_train)
    predictions_LR = logistc_model.predict(X_test)
    
    rf_classifier = RandomForestClassifier(225, verbose=1, bootstrap = True)
    rf_classifier.fit(X_train, y_train)
    predictions_RF = rf_classifier.predict(X_test)
    
    true = 0
    total = len(predictions_RF)
    for i in range(len(predictions_RF)):
        pred_ANN = np.where(predictions_ANN[i] == np.max(predictions_ANN[i]))[0]
        if most_frequent([int(pred_ANN),int(predictions_LR[i]),int(predictions_RF[i])]) == y_test[i]:
            true += 1
    
    error = 1-(true/total)
    
    return error


def most_frequent(List):
    counter = 0
    num = List[0]
     
    for i in List:
        curr_frequency = List.count(i)
        if(curr_frequency> counter):
            counter = curr_frequency
            num = i
 
    return num

error = Majority_Voting_Model(X_train,X_test,y_train,y_test)
print(error)