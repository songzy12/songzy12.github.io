---
layout: post
title: "OMEN WSL GPU"
date: 2022-08-31T20:18:22+08:00
---

Enable GPU on OMEN, which runs Win11 and WSL2.

<https://docs.nvidia.com/cuda/wsl-user-guide/index.html>

## Driver

<https://developer.nvidia.com/cuda/wsl>

**Then restart your computer**.

```
$ nvidia-smi

Sun Oct 24 20:28:01 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.28       Driver Version: 470.76       CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0  On |                  N/A |
| 30%   35C    P8    16W / 350W |   1782MiB / 24576MiB |    ERR!      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

NOTE: `nvidia-smi` only indicates highest CUDA version the installed driver supports. It does not provide any information about which CUDA version is installed or even whether there is CUDA installed at all.

### Verify

```
cd /usr/local/cuda-11.0/samples/4_Finance/BlackScholes
./BlackScholes
```

## Toolkit

> The latest NVIDIA Windows GPU Driver will fully support WSL 2. With CUDA support in the driver, existing applications (compiled elsewhere on a Linux system for the same target GPU) can run unmodified within the WSL environment.

> To compile new CUDA applications, a CUDA Toolkit for Linux x86 is needed. CUDA Toolkit support for WSL is still in preview stage as developer tools such as debugger and profilers are not available yet. However, CUDA application development is fully supported in the WSL2 environment, as a result, users should be able to compile new CUDA Linux applications with the latest CUDA Toolkit for x86 Linux.

> Once a Windows NVIDIA GPU driver is installed on the system, CUDA becomes available within WSL 2. The CUDA driver installed on Windows host will be stubbed inside the WSL 2 as libcuda.so, therefore users must not install any NVIDIA GPU Linux driver within WSL 2. One has to be very careful here as the default CUDA Toolkit comes packaged with a driver, and it is easy to overwrite the WSL 2 NVIDIA driver with the default installation. We recommend developers to use a separate CUDA Toolkit for WSL 2 (Ubuntu) available here to avoid this overwriting. This WSL-Ubuntu CUDA toolkit installer will not overwrite the NVIDIA driver that was already mapped into the WSL 2 environment. To learn how to compile CUDA applications, please read the CUDA documentation for Linux.

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

### Env Var

```
export CUDA_HOME="/usr/local/cuda-11.0"
export LD_LIBRARY_PATH="/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH"
export PATH="/usr/local/cuda-11.0/bin:$PATH"
```

### Verify

```
nvcc -V
```

## Reference

- <https://actruce.com/en/all-about-the-nvidia-driver-installation>

## Appendix

### Multiple CUDA Installed?

```
$ which nvcc
/usr/bin/nvcc

$ nvcc -V
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2019 NVIDIA Corporation
Built on Sun_Jul_28_19:07:16_PDT_2019
Cuda compilation tools, release 10.1, V10.1.243

$ whereis cuda
cuda: /usr/lib/cuda /usr/include/cuda.h

$ cat /usr/lib/cuda/version.txt 
CUDA Version 10.1.243

$ ls /usr/lib/cuda/bin 

```

```
$ ls /usr/local | grep cuda
cuda-11.0

$ cat /usr/local/cuda-11.0/version.txt 
CUDA Version 11.0.228

$ /usr/local/cuda-11.0/bin/nvcc -V
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2020 NVIDIA Corporation
Built on Wed_Jul_22_19:09:09_PDT_2020
Cuda compilation tools, release 11.0, V11.0.221
Build cuda_11.0_bu.TC445_37.28845127_0
```
