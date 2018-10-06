---
layout: post
title: "file formats"
date: 2016-12-24 14:12:29 +0800
comments: true
categories: Python

---

## csv

csv: comma seperated value

```
with open("data/rf_benchmark.csv", "wb") as f:
    writer = csv.writer(f)
    writer.writerow(["ImageId","Label"])
    for i, predicted_digit in enumerate(predicted_digits):
        writer.writerow((i+1, int(predicted_digit)))
```

## robotparser

```
>>> import robotparser
>>> rp = robotparser.RobotFileParser()
>>> rp.set_url("http://www.musi-cal.com/robots.txt")
>>> rp.read()
>>> rp.can_fetch("*", "http://www.musi-cal.com/cgi-bin/search?city=San+Francisco")
False
>>> rp.can_fetch("*", "http://www.musi-cal.com/")
True
```
