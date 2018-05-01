"""
10-701 Introduction to Machine Learning
Final Project

Generalized Disjunctive Programming (GDP)
Reformulation Classification using Neural Network

Neural Network Implementation using TensorFlow
"""

from __future__ import print_function
import numpy as np
import pandas as pd
import tensorflow as tf
import matplotlib.pyplot as plt

# Import Data
df_train = pd.read_csv('scaled_training_set_data',
                       header = None, delimiter=' ', engine='python')
df_test = pd.read_csv('scaled_test_set_data',
                       header = None, delimiter=' ', engine='python')

#Clean the data
for i in range(1, len(df_train.columns)):
    df_train[i] = df_train[i].map(lambda x: str(x)[2:])
#print(df_train)
for i in range(1, len(df_train.columns)):
    df_test[i] = df_test[i].map(lambda x: str(x)[2:])
#print(df_test)

#Get labels and features as nparray
labels_train = df_train.as_matrix(columns=[0])
features_train =df_train.as_matrix(columns=[1,2,3,4])
labels_test = df_test.as_matrix(columns=[0])
features_test =df_test.as_matrix(columns=[1,2,3,4])

from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
# Fit only to the training data
scaler.fit(features_train)

X_train = scaler.transform(features_train)
X_test = scaler.transform(features_test)

from sklearn.neural_network import MLPClassifier

mlp = MLPClassifier(hidden_layer_sizes=(5,5,5),max_iter=10000)
results = mlp.fit(X_train,labels_train.flatten())
print(results)

predictions = mlp.predict(X_test)
print(predictions)

from sklearn.metrics import classification_report,confusion_matrix

print(confusion_matrix(labels_test.flatten(),predictions))

print(classification_report(labels_test.flatten(),predictions))

print(mlp.coefs_)
print(labels_train.flatten())
print(features_train[0,:])

plt.scatter(X_train[:,2],X_train[:,1],c=labels_train.flatten())
plt.show()