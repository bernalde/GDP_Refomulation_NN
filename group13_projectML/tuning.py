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
# df_train = pd.read_csv('training_set_data',
#                        header = None, delimiter=' ', engine='python')
# df_test = pd.read_csv('test_set_data',
#                        header = None, delimiter=' ', engine='python')
df_train = pd.read_csv('../features/function_of_features/6features_alldata/training_set',
                       header = None, delimiter=' ', engine='python')
df_test = pd.read_csv('../features/function_of_features/6features_alldata/test_set',
                       header = None, delimiter=' ', engine='python')
# print(df_train)
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
from sklearn.preprocessing import MinMaxScaler
from sklearn import datasets

# different learning rate schedules and momentum parameters
params = [{'solver': 'sgd', 'learning_rate': 'constant', 'momentum': 0,
           'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'constant', 'momentum': .9,
           'nesterovs_momentum': False, 'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'constant', 'momentum': .9,
           'nesterovs_momentum': True, 'learning_rate_init': 0.1},
          {'solver': 'adam', 'learning_rate_init': 0.01},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': 0,
           'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': .9,
           'nesterovs_momentum': True, 'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'invscaling', 'momentum': .9,
           'nesterovs_momentum': False, 'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'adaptive', 'momentum': 0,
           'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'adaptive', 'momentum': .9,
           'nesterovs_momentum': True, 'learning_rate_init': 0.1},
          {'solver': 'sgd', 'learning_rate': 'adaptive', 'momentum': .9,
           'nesterovs_momentum': False, 'learning_rate_init': 0.1},
          {'solver': 'lbfgs'}
          ]

labels = ["constant learning-rate", "constant with momentum",
          "constant with Nesterov's momentum", "adam",
          "inv-scaling learning-rate", "inv-scaling with momentum",
          "inv-scaling with Nesterov's momentum",
          "adaptive learning-rate", "adaptive with momentum",
          "adaptive with Nesterov's momentum"
          , "lbfgs"
          ]

plot_args = [{'c': 'green', 'linestyle': '-'},
             {'c': 'red', 'linestyle': '-'},
             {'c': 'blue', 'linestyle': '-'},
             {'c': 'black', 'linestyle': '-'},
             {'c': 'green', 'linestyle': ':'},
             {'c': 'red', 'linestyle': ':'},
             {'c': 'blue', 'linestyle': ':'},
             {'c': 'green', 'linestyle': '--'},
             {'c': 'red', 'linestyle': '--'},
             {'c': 'blue', 'linestyle': '--'}
             ,{'c': 'cyan', 'linestyle': '-'}
             ]


X_train = MinMaxScaler().fit_transform(X_train)
mlps = []
max_iter = 1000

for label, param in zip(labels, params):
  print("training: %s" % label)
  mlp = MLPClassifier(hidden_layer_sizes=(4,4,4), verbose=0, random_state=random_state,
                            max_iter=max_iter, **param)
  mlp.fit(X_train,labels_train.flatten())
  mlps.append(mlp)
  print("Training set score: %f" % mlp.score(X_train,labels_train.flatten()))
  print("Training set loss: %f" % mlp.loss_)
  print("Training iterations: %f" % mlp.n_iter_)

fig = plt.figure(figsize=(20,10))
ax = plt.subplot(111)
for mlp, label, args in zip(mlps, labels, plot_args):
      if label == "lbfgs":
        continue
      else:
        ax.plot(mlp.loss_curve_, label=label, lw=5, **args)


# Shrink current axis's height by 10% on the bottom
box = ax.get_position()
ax.set_position([box.x0, box.y0 + box.height * 0.3,
                 box.width, box.height * 0.8])

ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2),
          fancybox=True, shadow=True, ncol=3, fontsize=18, framealpha=0)
plt.ylabel('Loss curve')
plt.xlabel('Iterations')


for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +
             ax.get_xticklabels() + ax.get_yticklabels()):
    item.set_fontsize(30)
fig.savefig('temp.png', transparent=True)
