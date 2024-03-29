---
layout: post
title: "TensorFlow 1.x GPU"
date: 2021-07-11T12:23:11+08:00
---

Enable GPU for TF 1.x with RTX 3090.

## Nvidia TensorFlow

<https://github.com/NVIDIA/tensorflow#install>

```
python3 -m pip install nvidia-pyindex
python3 -m pip install nvidia-tensorflow
```

## Verify

<https://www.tensorflow.org/api_docs/python/tf/test/is_gpu_available>

```
import tensorflow as tf

tf.test.is_gpu_available()

# For tf 2.x:
# tf.config.list_physical_devices('GPU')
```

## Reference 

- <https://developer.nvidia.com/blog/accelerating-tensorflow-on-a100-gpus/> 


## Appendix

### Tensorflow Tested Build from Source

<https://www.tensorflow.org/install/source#gpu>


| Version               | Python version | Compiler  | Build tools  | cuDNN | CUDA |
| --------------------- | -------------- | --------- | ------------ | ----- | ---- |
| tensorflow-2.4.0      | 3.6-3.8        | GCC 7.3.1 | Bazel 3.1.0  | 8.0   | 11.0 |
| tensorflow_gpu-1.15.0 | 2.7、3.3-3.7   | GCC 7.3.1 | Bazel 0.26.1 | 7.4   | 10.0 |

### Remove Python 3.7

```
sudo apt list --installed | grep python3.7
sudo apt remove python3.7
sudo apt autoremove
```
