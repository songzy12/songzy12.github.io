---
layout: post
title: "Supervisor"
date: 2019-02-28T14:02:05+08:00
categories: 
---

* reread - Reread supervisor configuration. Do not update or restart the running services.
* update - Restart service(s) whose configuration has changed. Usually run after 'reread'.
* reload - Reread supervisor configuration, reload supervisord and supervisorctl
* restart - Restart service(s)



## logging

```
import logging 

log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

ch = logging.StreamHandler(sys.stdout)

ch.setLevel(logging.DEBUG)

formatter = logging.Formatter(
    "%(asctime)s - %(name)s - %(levelname)s - %(message)s")
ch.setFormatter(formatter)

log.addHandler(ch)
```

