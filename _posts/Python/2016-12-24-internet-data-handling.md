---
layout: post
title: "Internet Data Handling"
date: 2016-12-24 14:17:35 +0800
comments: true
categories: Python

---

## json

```
import json
dict = {"hello": "world"}
json.dumps(dict, separators=(',', ': '))
json.dumps(dict, sort_keys=True, indent=4, separators=(',', ': '))
```
