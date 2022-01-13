import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, models, Sequential



def NeuralNetworkModel(X_train,X_test,y_train,y_test,HiddenLayers):
    
    model = models.Sequential()
    
    for i in range(HiddenLayers):
        model.add(layers.Dense(8, activation='relu'))
    
    model.add(layers.Dense(15, activation='softmax'))

    model.compile(loss=tf.keras.losses.SparseCategoricalCrossentropy(), optimizer='adam', metrics=['accuracy'])
    
    # Fitting our model to our data
    model.fit(X_train, y_train, batch_size = 32, epochs=150, validation_data=(X_test, y_test))
    
    predictions = np.array(model.predict(X_test))
    
    true = 0
    total = len(predictions)
    for i in range(len(predictions)):
        
        pred = np.where(predictions[i] == np.max(predictions[i]))[0]
        
        if pred == y_test[i]:
            true += 1
    
    error = 1-(true/total)
    
    print(predictions)
    
    return error
