---
layout: post
title: "Custom Python Interpreters"
date: 2016-12-24 14:08:23 +0800
comments: true
categories: Python

---

## code

```
import code
code.interact(banner=None,local=dict(locals(), **globals()))
```

`banner` is just the banner (title) of the interact console.

After you press `Ctrl-D`, the code will continue to execute.