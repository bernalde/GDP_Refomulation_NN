"""
10-701 Introduction to Machine Learning
Final Project

Generalized Disjunctive Programming (GDP)
Reformulation Classification using Neural Network

Neural Network Implementation
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

random_state = 3131131

# Import Data
# df_train = pd.read_csv('../features/function_of_features/all_raw_features/training_set_data_withoutstrip52',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('../features/function_of_features/all_raw_features/test_set_data_withoutstrip52',
#                        header = None, delimiter=' ', engine='python')
# df_train = pd.read_csv('../features/function_of_features/6features_withoutstrip52/training_set_data',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('../features/function_of_features/6features_withoutstrip52/test_set_data',
#                        header = None, delimiter=' ', engine='python')
df_train = pd.read_csv('../features/function_of_features/6features_alldata/training_set',
                       header = None, delimiter=' ', engine='python')
df_test = pd.read_csv('../features/function_of_features/6features_alldata/test_set',
                       header = None, delimiter=' ', engine='python')
# df_train = pd.read_csv('./scaled_training_set_data',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('./scaled_test_set_data',
#                        header = None, delimiter=' ', engine='python')

#Clean the data
groups_train = df_train[0].map(lambda x: str(x)[58:59])
groups_test = df_test[0].map(lambda x: str(x)[58:59])
df_train[0] = df_train[0].map(lambda x: str(x)[-1:])
df_test[0] = df_test[0].map(lambda x: str(x)[-1:])
#Clean the data
for i in range(1, min(len(df_train.columns),10)):
    df_train[i] = df_train[i].map(lambda x: str(x)[2:])
    df_test[i] = df_test[i].map(lambda x: str(x)[2:])
#Clean the data
if len(df_train.columns) > 10:
    for i in range(10, len(df_train.columns)):
        df_train[i] = df_train[i].map(lambda x: str(x)[3:])
        df_test[i] = df_test[i].map(lambda x: str(x)[3:])
# print(df_train)

#Get labels and features as nparray
labels_train = df_train.as_matrix(columns=[0])
features_train =df_train.as_matrix(columns=df_train.columns[1:len(df_train.columns)])
labels_test = df_test.as_matrix(columns=[0])
features_test =df_test.as_matrix(columns=df_test.columns[1:len(df_train.columns)])

from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
# Fit only to the training data
scaler.fit(features_train)

X_train = scaler.transform(features_train)
X_test = scaler.transform(features_test)
y_train = labels_train.flatten()
y_test = labels_test.flatten()

from sklearn.neural_network import MLPClassifier
from sklearn.metrics import classification_report,confusion_matrix 
from sklearn.model_selection import GroupKFold
from sklearn.model_selection import GridSearchCV
group_kfold = GroupKFold(n_splits=4)
group_kfold.get_n_splits(X_train, y_train, groups_train)

tuned_parameters = [{'hidden_layer_sizes': [[6,6,6]]},
                    {'hidden_layer_sizes': [[3,3,3]]},
                    {'hidden_layer_sizes': [[5,5,5]]},
                    {'hidden_layer_sizes': [[6,6]]},
                    {'hidden_layer_sizes': [[5,5]]},
                    {'hidden_layer_sizes': [[3,3]]},
                    {'hidden_layer_sizes': [[6,5,3]]},
                    {'hidden_layer_sizes': [[3,5,6]]},
                    {'hidden_layer_sizes': [[6,5]]},
                    {'hidden_layer_sizes': [[6,3]]},
                    {'hidden_layer_sizes': [[5,6]]},
                    {'hidden_layer_sizes': [[3,5]]},
                    {'hidden_layer_sizes': [[3,6]]},
                    {'hidden_layer_sizes': [[5,3]]},
                    {'hidden_layer_sizes': [[4,4,4]]}]

scores = ['precision', 'recall', 'f1']

for score in scores:
    print("# Tuning hyper-parameters for %s" % score)
    print()

    clf = GridSearchCV(MLPClassifier(max_iter=10000,random_state=random_state), tuned_parameters, cv=group_kfold.get_n_splits(X_train, y_train, groups_train),
                       scoring='%s_macro' % score)
    clf.fit(X_train, y_train)

    print("Best parameters set found on development set:")
    print()
    print(clf.best_params_)
    print()
    print("Grid scores on development set:")
    print()
    means = clf.cv_results_['mean_test_score']
    stds = clf.cv_results_['std_test_score']
    for mean, std, params in zip(means, stds, clf.cv_results_['params']):
        print("%0.3f (+/-%0.03f) for %r"
              % (mean, std * 2, params))
    print()

    print("Detailed classification report:")
    print()
    print("The model is trained on the full development set.")
    y_trained = clf.predict(X_train)
    print(confusion_matrix(y_train, y_trained))
    print("The scores are computed on the full evaluation set.")
    print()
    y_true, y_pred = y_test, clf.predict(X_test)
    print(classification_report(y_true, y_pred))
    print(confusion_matrix(y_true, y_pred))
    print()

