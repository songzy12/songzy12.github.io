---
layout: post
title: "Numeric and Mathematical Modules"
date: 2016-12-24 14:16:38 +0800
comments: true
categories: Python

---

## fractions

```
from fracions import gcd
print gcd(20, 4)
```

## itertools

```
groups = []
uniquekeys = []
data = sorted(data, key=keyfunc)
for k, g in groupby(data, keyfunc):
    groups.append(list(g))      # Store group iterator as a list
    uniquekeys.append(k)
```

## random

```
import random
random.randrange(start, stop[, step]) # random.choice(range(start, stop, step))
random.randint(a, b)
random.shuffle(x[, random])
random.random()
random.uniform(a, b)

random.choice(seq)
```
