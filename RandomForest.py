# Random forest classifier
import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import KFold


df = pd.read_csv("Data/armdataPreprocessedAllLabels.csv")

data = df.to_numpy()

X = data[:,0]
y1 = data[:,4]
y2 = data[:,5]

# K = 10 fold cross validation
K1, K2 = 10

CV1 = KFold(K1, shuffle = True)
CV2 = KFold(K2, shuffle = True)


