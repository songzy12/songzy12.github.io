---
layout: post
title: "PyTorch GPU"
date: 2023-03-21T23:01:43+08:00
---

Enable GPU for PyTorch.

## Verify

```
>>> import torch
>>> torch.cuda.is_available()
True
>>> torch.cuda.device_count()
1
>>> torch.cuda.current_device()
0
>>> torch.cuda.device(0)
<torch.cuda.device object at 0x7f41013064f0>
>>> torch.cuda.get_device_name(0)
'NVIDIA GeForce RTX 3090'
```
