---
layout: post
title: "Paddle GPU"
date: 2023-03-21T15:23:08+08:00
---

Enable GPU for PaddlePaddle.

<https://stackoverflow.com/questions/9727688/how-to-get-the-cuda-version>

```
$ nvcc --version
```

<https://www.paddlepaddle.org.cn/install/quick?docurl=/documentation/docs/zh/install/pip/linux-pip.html>

```
pip install paddlepaddle-gpu==2.1.3.post110 -f https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html
```