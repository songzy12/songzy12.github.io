---
layout: post
title: "Guest VM Network"
date: 2023-07-15T13:52:26+00:00
---

Set up http/https Proxy on WSL.

```
windows_host=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
export http_proxy=http://$windows_host:10809
export https_proxy=http://$windows_host:10809
```
