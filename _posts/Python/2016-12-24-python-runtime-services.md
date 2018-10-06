---
layout: post
title: "Python Runtime Services"
date: 2016-12-24 14:26:34 +0800
comments: true
categories: Python

---

## sys

```
import sys
f_in = open('in.txt', 'r+')
f_out = open('out.txt', 'w+')
sys.stdin = f_in
sys.stdout = f_out

f_in.close()
f_out.close()
```

## traceback

```
try:
    execfile("test.py")
except Exception as e:
	import traceback, code
	traceback.print_exc()
	with open('log.txt', 'w') as f:
	    traceback.print_exc(file=f)
    code.interact(local=dict(globals(), **locals()))
```