import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

random_state = 12883823

# Import Data
# df_train = pd.read_csv('../features/function_of_features/all_raw_features/training_set_data_withoutstrip52',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('../features/function_of_features/all_raw_features/test_set_data_withoutstrip52',
#                        header = None, delimiter=' ', engine='python')
# df_train = pd.read_csv('../features/function_of_features/6features_withoutstrip52/training_set_data',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('../features/function_of_features/6features_withoutstrip52/test_set_data',
#                        header = None, delimiter=' ', engine='python')
df_train = pd.read_csv('training_set_data',
                       header = None, delimiter=' ', engine='python')
df_test = pd.read_csv('test_set_data',
                       header = None, delimiter=' ', engine='python')
# print(df_train)
# df_train = pd.read_csv('./scaled_training_set_data',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('./scaled_test_set_data',
#                        header = None, delimiter=' ', engine='python')

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

from sklearn.neural_network import MLPClassifier
from sklearn.preprocessing import MinMaxScaler
from sklearn import datasets

# different learning rate schedules and momentum parameters
params = [{'solver': 'sgd', 'learning_rate': 'constant', 'momentum': 0,
           'learning_rate_init': 0.2},
          {'solver': 'sgd', 'learning_rate': 'constant', 'momentum': .9,
           'nesterovs_momentum': False, 'learning_rate_init': 0.2},
          {'solver': 'sgd', 'learning_rate': 'constant', 'momentum': .9,
           'nesterovs_momentum': True, 'learning_rate_init': 0.2},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': 0,
           'learning_rate_init': 0.2},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': .9,
           'nesterovs_momentum': True, 'learning_rate_init': 0.2},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': .9,
           'nesterovs_momentum': False, 'learning_rate_init': 0.2},
          {'solver': 'adam', 'learning_rate_init': 0.01}]

labels = ["constant learning-rate", "constant with momentum",
          "constant with Nesterov's momentum",
          "inv-scaling learning-rate", "inv-scaling with momentum",
          "inv-scaling with Nesterov's momentum", "adam"]

plot_args = [{'c': 'red', 'linestyle': '-'},
             {'c': 'green', 'linestyle': '-'},
             {'c': 'blue', 'linestyle': '-'},
             {'c': 'red', 'linestyle': '--'},
             {'c': 'green', 'linestyle': '--'},
             {'c': 'blue', 'linestyle': '--'},
             {'c': 'black', 'linestyle': '-'}]


X_train = MinMaxScaler().fit_transform(X_train)
mlps = []
max_iter = 1000

for label, param in zip(labels, params):
  print("training: %s" % label)
  mlp = MLPClassifier(hidden_layer_sizes=(5,5,5), verbose=0, random_state=random_state,
                            max_iter=max_iter, **param)
  mlp.fit(X_train,labels_train.flatten())
  mlps.append(mlp)
  print("Training set score: %f" % mlp.score(X_train,labels_train.flatten()))
  print("Training set loss: %f" % mlp.loss_)
for mlp, label, args in zip(mlps, labels, plot_args):
      plt.plot(mlp.loss_curve_, label=label, **args)

plt.legend(labels, loc="upper right")
plt.ylabel('Loss curve')
plt.show()