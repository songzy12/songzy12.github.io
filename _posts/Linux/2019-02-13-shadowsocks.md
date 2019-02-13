---
layout: post
title: "Shadowsocks"
date: 2019-02-13 19:45:03 +0800
comments: true
categories: 

---

```
1E#m2WXS9LdvTCNA
tail -f /var/log/syslog
```

Chrome 标签不同步也可能是因为 GFW 无法连接 Google 服务所致。

## socls

```
import urllib2
import socks
from sockshandler import SocksiPyHandler

opener = urllib2.build_opener(SocksiPyHandler(socks.SOCKS5, "127.0.0.1", 1080))
x = opener.open("http://www.youtube.com/")
print x.read()
```

## ss client

<http://www.sundabao.com/ubuntu%E4%BD%BF%E7%94%A8shadowsocks/>

```
sudo apt-get update
sudo apt-get install python-pip
sudo apt-get install python-setuptools m2crypto
pip install shadowsocks
sudo apt install shadowsocks
```

```
sslocal -s 11.22.33.44 -p 50003 -k "123456" -l 1080 -t 600 -m aes-256-cfb
```

```
vi config.json
```

```
{
    "server":"11.22.33.44",
    "server_port":50003,
    "local_port":1080,
    "password":"123456",
    "timeout":600,
    "method":"aes-256-cfb"
}
```

```
sslocal -c shadowsocks.json
```

SwitchyOmega: <https://github.com/FelisCatus/SwitchyOmega/releases/>

```
nohup sslocal -c shadowsocks.json &
```

## ss server

```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log
```

```
vi /etc/shadowsocks.json
```

```
{
    "server":"45.32.251.88",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"shadowsocks",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

```
https://github.com/shadowsocks/shadowsocks-windows/releases
```

```
ssserver -c /etc/shadowsocks.json -d start
ssserver -c /etc/shadowsocks.json -d stop
```

```
sudo less /var/log/shadowsocks.log
```