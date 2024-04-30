---
layout: post
title: "WSL HTTP Proxy"
date: 2023-07-15T13:52:26+00:00
---

Set up http/https proxy on WSL.

```
windows_host=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
export http_proxy=http://$windows_host:10811
export https_proxy=http://$windows_host:10811
export HTTP_PROXY=http://$windows_host:10811
export HTTPS_PROXY=http://$windows_host:10811
```

Remember to check your vpn client port configuration.
