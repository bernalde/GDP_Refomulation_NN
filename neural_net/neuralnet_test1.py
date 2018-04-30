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
#header = ['labels', 'sparsity', 'gap', 'vars', 'cons']
#features = ['sparsity', 'gap', 'vars', 'cons']
#df_train.columns = header
#df_test.columns = header

#Clean the data
for i in range(1, len(df_train.columns)):#features:
    df_train[i] = df_train[i].map(lambda x: str(x)[2:])
#print(df_train)
for i in range(1, len(df_train.columns)):#features:
    df_test[i] = df_test[i].map(lambda x: str(x)[2:])
#print(df_test)

#Get labels and features as nparray
labels_train = df_train.as_matrix(columns=[0])#(columns=['labels'])
features_train =df_train.as_matrix(columns=[1,2,3,4])#(columns=features)
labels_test = df_test.as_matrix(columns=[0])#(columns=['labels'])
features_test =df_test.as_matrix(columns=[1,2,3,4])#(columns=features)

#Convert training to tensorflow dataset
#tf_train_data = tf.data.Dataset.from_tensor_slices((features_train,labels_train))
#print(tf_train_data)

# Model architecture parameters
n_features = features_train.shape[1]
n_neurons_1 = 5
n_neurons_2 = 5
n_neurons_3 = 5
n_neurons_4 = 5
n_neurons_5 = 5
n_target = 1

# Placeholder
X = tf.placeholder(dtype=tf.float32, shape=[None, n_features])
Y = tf.placeholder(dtype=tf.float32, shape=[None, n_target])

# Initializers
sigma = 1
weight_initializer = tf.variance_scaling_initializer(mode="fan_avg", distribution="uniform", scale=sigma)
bias_initializer = tf.zeros_initializer()

# Layer 1: Variables for hidden weights and biases
W_hidden_1 = tf.Variable(weight_initializer([n_features, n_neurons_1]))
bias_hidden_1 = tf.Variable(bias_initializer([n_neurons_1]))
# Layer 2: Variables for hidden weights and biases
W_hidden_2 = tf.Variable(weight_initializer([n_neurons_1, n_neurons_2]))
bias_hidden_2 = tf.Variable(bias_initializer([n_neurons_2]))
# Layer 3: Variables for hidden weights and biases
W_hidden_3 = tf.Variable(weight_initializer([n_neurons_2, n_neurons_3]))
bias_hidden_3 = tf.Variable(bias_initializer([n_neurons_3]))
# Layer 4: Variables for hidden weights and biases
W_hidden_4 = tf.Variable(weight_initializer([n_neurons_3, n_neurons_4]))
bias_hidden_4 = tf.Variable(bias_initializer([n_neurons_4]))
# Layer 5: Variables for hidden weights and biases
W_hidden_5 = tf.Variable(weight_initializer([n_neurons_4, n_neurons_5]))
bias_hidden_5 = tf.Variable(bias_initializer([n_neurons_5]))
# Output layer: Variables for output weights and biases
W_out = tf.Variable(weight_initializer([n_neurons_5, n_target]))
bias_out = tf.Variable(bias_initializer([n_target]))

# Hidden layer
hidden_1 = tf.nn.relu(tf.add(tf.matmul(X, W_hidden_1), bias_hidden_1))
hidden_2 = tf.nn.relu(tf.add(tf.matmul(hidden_1, W_hidden_2), bias_hidden_2))
hidden_3 = tf.nn.relu(tf.add(tf.matmul(hidden_2, W_hidden_3), bias_hidden_3))
hidden_4 = tf.nn.relu(tf.add(tf.matmul(hidden_3, W_hidden_4), bias_hidden_4))
hidden_5 = tf.nn.relu(tf.add(tf.matmul(hidden_4, W_hidden_5), bias_hidden_5))
# Output layer (must be transposed)
out = tf.transpose(tf.add(tf.matmul(hidden_5, W_out), bias_out))

# Cost function
mse = tf.reduce_mean(tf.squared_difference(out, Y))

# Optimizer
opt = tf.train.AdamOptimizer().minimize(mse)

# Make Session
net = tf.Session()
# Run initializer
net.run(tf.global_variables_initializer())

# Setup interactive plot
plt.ion()
fig = plt.figure()
ax1 = fig.add_subplot(111)
line1, = ax1.plot(labels_test)
line2, = ax1.plot(labels_test*0.5)
plt.show()

# Number of epochs and batch size
epochs = 100
batch_size = 500

for e in range(epochs):

    # Shuffle training data
    shuffle_indices = np.random.permutation(np.arange(len(labels_train)))
    features_train = features_train[shuffle_indices]
    labels_train = labels_train[shuffle_indices]

    # Minibatch training
    for i in range(0, len(labels_train) // batch_size):
        start = i * batch_size
#        print(start)
        batch_x = features_train[start:start + batch_size]
        batch_y = labels_train[start:start + batch_size]
        # Run optimizer with batch
        net.run(opt, feed_dict={X: batch_x, Y: batch_y})
        # Show progress
        if np.mod(i, 5) == 0:
            # Prediction
            pred = net.run(out, feed_dict={X: features_test})
            line2.set_ydata(pred)
            plt.title('Epoch ' + str(e) + ', Batch ' + str(i))
            file_name = 'img/epoch_' + str(e) + '_batch_' + str(i) + '.jpg'
            plt.savefig(file_name)
            plt.pause(0.01)
# Print final MSE after Training
mse_final = net.run(mse, feed_dict={X: features_test, Y: labels_test})
print('final mse')
print(mse_final)
