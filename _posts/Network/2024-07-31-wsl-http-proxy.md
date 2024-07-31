---
layout: post
title: "WSL HTTP Proxy"
date: 2024-07-31T13:52:26+00:00
---

Set up http/https proxy inside WSL.

<https://learn.microsoft.com/en-us/windows/wsl/networking>

## NAT

```
WINDOWS_HOST=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
PROXY_PORT=10809

export http_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export https_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export HTTP_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
export HTTPS_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
```

Remember to check your vpn client monitored port configuration.

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
PROXY_PORT=10809

export http_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export https_proxy=http://$WINDOWS_HOST:$PROXY_PORT
export HTTP_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
export HTTPS_PROXY=http://$WINDOWS_HOST:$PROXY_PORT
```
