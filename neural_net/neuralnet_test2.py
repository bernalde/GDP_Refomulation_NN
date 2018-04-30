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

#Create tensorflow Dataset
#training_data = tf.data.Dataset.from_tensor_slices((features_train, labels_train))

# Parameters
n_features = features_train.shape[1]
n_neurons_1 = 2
n_neurons_2 = 2
n_neurons_3 = 2
n_neurons_4 = 2
n_neurons_5 = 2
n_target = 1
learning_rate = 0.01
training_epochs = 15
batch_size = 100
display_step = 1

# Placeholder
X = tf.placeholder("float", shape=[None, n_features])
Y = tf.placeholder("float", shape=[None, n_target])

# Store layers weight & bias
weights = {
    'h1': tf.Variable(tf.random_normal([n_features, n_neurons_1])),
    'h2': tf.Variable(tf.random_normal([n_neurons_1, n_neurons_2])),
    'h3': tf.Variable(tf.random_normal([n_neurons_2, n_neurons_3])),
    'h4': tf.Variable(tf.random_normal([n_neurons_3, n_neurons_4])),
    'h5': tf.Variable(tf.random_normal([n_neurons_4, n_neurons_5])),
    'out': tf.Variable(tf.random_normal([n_neurons_5, n_target]))
}
biases = {
    'b1': tf.Variable(tf.random_normal([n_neurons_1])),
    'b2': tf.Variable(tf.random_normal([n_neurons_2])),
    'b3': tf.Variable(tf.random_normal([n_neurons_3])),
    'b4': tf.Variable(tf.random_normal([n_neurons_4])),
    'b5': tf.Variable(tf.random_normal([n_neurons_5])),
    'out': tf.Variable(tf.random_normal([n_target]))
}

# Create model
def multilayer_perceptron(x):
    # Hidden fully connected layers
    layer_1 = tf.add(tf.matmul(x, weights['h1']), biases['b1'])
    layer_2 = tf.add(tf.matmul(layer_1, weights['h2']), biases['b2'])
    layer_3 = tf.add(tf.matmul(layer_2, weights['h3']), biases['b3'])
    layer_4 = tf.add(tf.matmul(layer_3, weights['h4']), biases['b4'])
    layer_5 = tf.add(tf.matmul(layer_4, weights['h5']), biases['b5'])
    # Output fully connected layer with a neuron for each class
    out_layer = tf.matmul(layer_5, weights['out']) + biases['out']
    return out_layer

# Construct model
logits = multilayer_perceptron(X)

# Define loss and optimizer
loss_op = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(
    logits=logits, labels=Y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate)
train_op = optimizer.minimize(loss_op)
# Initializing the variables
init = tf.global_variables_initializer()

with tf.Session() as sess:
    sess.run(init)

    # Training cycle
    for epoch in range(training_epochs):
        avg_cost = 0.

        # Shuffle training data
        shuffle_indices = np.random.permutation(np.arange(len(labels_train)))
        features_train = features_train[shuffle_indices]
        labels_train = labels_train[shuffle_indices]

        # Minibatch training
        total_batch = len(labels_train) // batch_size
        for i in range(0, total_batch):
            start = i * batch_size
#           print(start)
            batch_x = features_train[start:start + batch_size]
            batch_y = labels_train[start:start + batch_size]
            # Run optimization op (backprop) and cost op (to get loss value)
            _, c = sess.run([train_op, loss_op], feed_dict={X: batch_x,
                                                            Y: batch_y})
            # Compute average loss
            avg_cost += c / total_batch
        # Display logs per epoch step
        if epoch % display_step == 0:
            print("Epoch:", '%04d' % (epoch+1), "cost={:.9f}".format(avg_cost), "accuracy={:.9f}".format)
    print("Optimization Finished!")

    # Test model
    pred = tf.nn.softmax(logits)  # Apply softmax to logits
    correct_prediction = tf.equal(tf.argmax(pred, 1), tf.argmax(Y, 1))
    # Calculate accuracy
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
    print("Accuracy test:", accuracy.eval({X: features_test, Y: labels_test}))
    print("Accuracy training:", accuracy.eval({X: features_train, Y: labels_train}))
