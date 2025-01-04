---
layout: post
title: "WSL HTTP Proxy"
date: 2025-01-04T23:20:26+08:00
---

Set up http/https proxy inside WSL.

<https://learn.microsoft.com/en-us/windows/wsl/networking>

## Port

If the v2ray has the following setting:

```
本地：[socks:10808] | [http:10809]
局域网：[socks:10810] | [http:10811]
```

Then:

```
PROXY_PORT=10811
```

## NAT

```
WINDOWS_HOST=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`

export http_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export https_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export HTTP_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
export HTTPS_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
```

## Mirrored

In `C:\Users\songz\.wslconfig` of Windows host: 

```
[experimental]
autoMemoryReclaim=gradual  # gradual  | dropcache | disabled
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```

Then in WSL2:

```
WINDOWS_HOST=localhost

export http_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export https_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export HTTP_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
export HTTPS_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
```
