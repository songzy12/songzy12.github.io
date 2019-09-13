---
layout: post
title: "TensorFlow"
date: 2016-11-05 20:42:05 +0800
comments: true
categories: Python

---

## tf.compat.as_str

`as_str` converts an object to a `str`.

## tf.Graph

```
graph = tf.Graph()

with graph.as_default():
    nce_biases = tf.Variable(tf.zeros([vocab_size]))
    init = tf.initialize_all_variables()
```

## tf.truncated_normal

```
The generated values follow a normal distribution with specified mean and standard deviation, except that values whose magnitude is more than 2 standard deviations from the mean are dropped and re-picked.
```

## tf.reduce_mean

When you are computing `tfMean = tf.reduce_mean(c)`, tensorflow doesn't compute it then. It only computes that in a Session. But numpy computes that instantly, when you write `np.mean()`

```
reduce_mean(input_tensor, reduction_indices=None, keep_dims=False, name=None)
input_tensor: The tensor to reduce. Should have numeric type.
reduction_indices: The dimensions to reduce. If `None` (the defaut),
    reduces all dimensions.

# 'x' is [[1., 1. ]]
#         [2., 2.]]
tf.reduce_mean(x) ==> 1.5
tf.reduce_mean(x, 0) ==> [1.5, 1.5] 
tf.reduce_mean(x, 1) ==> [1.,  2.]
```

## tf.initialize_all_variables

The difference is that with `tf.Variable` you have to provide an initial value when you declare it. With `tf.placeholder` you don't have to provide an initial value and you can specify it at run time with the `feed_dict` argument inside `Session.run`

In short, you use `tf.Variable` for trainable variables such as weights (W) and biases (B) for your model.

```
weights = tf.Variable(
    tf.truncated_normal([IMAGE_PIXELS, hidden1_units],
                    stddev=1.0 / math.sqrt(float(IMAGE_PIXELS))), name='weights')

biases = tf.Variable(tf.zeros([hidden1_units]), name='biases')
```

`tf. placeholder` is used to feed actual training examples.

```
images_placeholder = tf.placeholder(tf.float32, shape=(batch_size, IMAGE_PIXELS))
labels_placeholder = tf.placeholder(tf.int32, shape=(batch_size))
```

This is how you feed the training examples during the training:

```
for step in xrange(FLAGS.max_steps):
    feed_dict = {
       images_placeholder: images_feed,
       labels_placeholder: labels_feed,
     }
    _, loss_value = sess.run([train_op, loss], feed_dict=feed_dict)
```

Your `tf.variables` will be trained (modified) as the result of this training.

## tf.nn.embedding_lookup

```
# Look up embeddings for inputs
embed = tf.nn.embedding_lookup(embeddings, train_inputs)
```

## tf.nn.nce_loss

Computes and returns the noise-contrastive estimation training loss.

Note: By default this uses a log-uniform (Zipfian) distribution for sampling,
so your labels must be sorted in order of decreasing frequency to achieve
good results.

```
loss = tf.reduce_mean(
    tf.nn.nce_loss(nce_weights, nce_biases, embed, train_labels,
                   num_sampled, vocab_size))
```

## tf.train

```
# Construct the SGD optimizer using a learning rate of 1.0.
optimizer = tf.train.GradientDescentOptimizer(1.0).minimize(loss)
```

## tf.Session

```
with tf.Session(graph=graph) as sess:
    init.run()
    print('Initialized')
```

## eval

`t.eval()` is a shortcut for calling `tf.get_default_session().run(t)`

You can use `sess.run()` to fetch the values of many tensors in the same step

Note that each call to `eval` and `run` will execute the whole graph from scratch.

```
normed_embeddings.eval()
```