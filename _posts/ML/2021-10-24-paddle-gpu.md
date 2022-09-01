---
layout: post
title: "Paddle GPU"
date: 2021-10-21T15:43:08+08:00
---

Enable GPU for PaddlePaddle.

```
W1024 17:30:14.785153  6727 device_context.cc:404] Please NOTE: device: 0, GPU Compute Capability: 8.6, Driver API Version: 11.4, Runtime API Version: 10.2
W1024 17:30:14.788581  6727 device_context.cc:422] device: 0, cuDNN Version: 8.1.
Traceback (most recent call last):
  File "train.py", line 63, in <module>
    model = FastText(vocab_size, num_classes, args.emb_dim)
  File "/home/songzy/fastText-paddle/model.py", line 21, in __init__
    self.embedder = nn.Embedding(vocab_size, emb_dim)
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/nn/layer/common.py", line 1343, in __init__
    self.weight = self.create_parameter(
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/dygraph/layers.py", line 411, in create_parameter
    return self._helper.create_parameter(temp_attr, shape, dtype, is_bias,
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/layer_helper_base.py", line 369, in create_parameter
    return self.main_program.global_block().create_parameter(
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/framework.py", line 2920, in create_parameter
    initializer(param, self)
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/initializer.py", line 561, in __call__
    op = block.append_op(
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/framework.py", line 2946, in append_op
    _dygraph_tracer().trace_op(type,
  File "/home/songzy/.virtualenvs/paddle/lib/python3.8/site-packages/paddle/fluid/dygraph/tracer.py", line 43, in trace_op
    self.trace(type, inputs, outputs, attrs,
SystemError: (Fatal) Operator uniform_random raises an thrust::system::system_error exception.
The exception content is
:parallel_for failed: cudaErrorNoKernelImageForDevice: no kernel image is available for execution on the device. (at /paddle/paddle/fluid/imperative/tracer.cc:192)
```


```
$ python
>>> import paddle
>>> paddle.utils.run_check() 
```

这种情况一般出现在编译和运行在不同架构的显卡上，且cmake时未指定运行时需要的CUDA架构。可以在cmake时加上 -DCUDA_ARCH_NAME=All（或者特定的架构如Turing、Volta、Pascal等），否则会使用默认值Auto，此时只会当前的CUDA架构编译。

<https://stackoverflow.com/questions/9727688/how-to-get-the-cuda-version>

```
$ nvcc --version
```

<https://www.paddlepaddle.org.cn/install/quick?docurl=/documentation/docs/zh/install/pip/linux-pip.html>

```
pip install paddlepaddle-gpu==2.1.3.post110 -f https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html
```