---
layout: post
title: "Ubuntu Service Management"
date: 2019-02-28T14:02:05+08:00
categories: 
---

Service/Job management on Ubuntu.

## supervisor

* reread - Reread supervisor configuration. Do not update or restart the running services.
* update - Restart service(s) whose configuration has changed. Usually run after 'reread'.
* reload - Reread supervisor configuration, reload supervisord and supervisorctl
* restart - Restart service(s)

## service

```
service ssh status
service ssh restart

netstat –nlp | grep 22
```

## tee

```
tee 
```

In computing, `tee` is a command in command-line interpreters (shells) using standard streams which reads standard input and writes it to both standard output and one or more files, effectively duplicating its input.
