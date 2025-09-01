---
layout: post
title: "V2Ray Server - Ubuntu"
date: 2025-04-04T10:08:09+08:00
---

How to set up v2ray server on Ubuntu.

<https://github.com/v2fly/fhs-install-v2ray>

## v2fly

```
// 安裝執行檔和 .dat 資料檔
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

// 只更新 .dat 資料檔
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)
```

## ufw

```
ufw allow http
ufw allow https
```

## config

```
vi /usr/local/etc/v2ray/config.json
```

### server

```
{
  "inbounds": [
    {
      "port": 443,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "899cbb8a-fad2-45bd-8608-8483956d641c",
            "level": 1,
            "alterId": 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/usr/local/etc/v2ray/songzy.cc.cer",
              "keyFile": "/usr/local/etc/v2ray/songzy.cc.key"
            }
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ]
}
```

Note: remember to set the value `inbounds.settings.clients.id` correctly.

## tls (acme.sh)

```
DOMAIN_NAME=songzy.cc
```

### install

```
apt install socat
curl https://get.acme.sh | sh
source ~/.bashrc 
```

### register

```
acme.sh --register-account -m songzy_thu@163.com
```

### issue & installcert

```
acme.sh --issue -d $DOMAIN_NAME --standalone -k ec-256 --debug
```

```
acme.sh --installcert -d $DOMAIN_NAME --fullchainpath /usr/local/etc/v2ray/$DOMAIN_NAME.cer --keypath /usr/local/etc/v2ray/$DOMAIN_NAME.key --ecc
```

### renew

```
acme.sh --renew -d $DOMAIN_NAME --force --ecc --debug
```

### vmess aead

```
env v2ray.vmess.aead.forced=false /usr/local/bin/v2ray run -config /usr/local/etc/v2ray/config.json
```

## ip check

<https://www.toolsdaquan.com/ipcheck/>
