---
layout: post
title: "TensorFlow GPU"
date: 2021-07-11T12:23:11+08:00
---

Enable TF 1.15 with RTX 3090.

## CUDA

<https://docs.nvidia.com/cuda/wsl-user-guide/index.html>

### Driver

<https://developer.nvidia.com/cuda/wsl>

**Then restart your computer**.

#### Verify

```
cd /usr/local/cuda-11.0/samples/4_Finance/BlackScholes
./BlackScholes
```

### Toolkit

<https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local>

```
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda-repo-wsl-ubuntu-11-7-local_11.7.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-11-7-local_11.7.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
```

#### Env Var

```
cd /usr/local/cuda-11.0/targets/x86_64-linux/lib
sudo ln -s libcusolver.so.10 libcusolver.so.11
```

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/targets/x86_64-linux/lib
```

## TensorFlow 1.15.4

### Nvidia TensorFlow

<https://github.com/NVIDIA/tensorflow#install>

```
python3 -m pip install nvidia-pyindex
python3 -m pip install nvidia-tensorflow
```

### Verify

<https://www.tensorflow.org/api_docs/python/tf/test/is_gpu_available>

```
import tensorflow as tf

tf.config.list_physical_devices('GPU')
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
