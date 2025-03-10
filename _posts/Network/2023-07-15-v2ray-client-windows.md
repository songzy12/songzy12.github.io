---
layout: post
title: "V2Ray Client - Windows"
date: 2023-07-15T04:23:45+00:00
---

Set up v2ray client on Windows.

<https://github.com/2dust/v2rayN/releases>

## routing

### config.json

```
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "enabled": true
      },
      {
        "type": "field",
        "outboundTag": "block",
        "domain": [
          "geosite:category-ads-all"
        ],
        "enabled": true
      },
      {
        "type": "field",
        "outboundTag": "direct",
        "domain": [
          "geosite:cn"
        ],
        "enabled": true
      },
      {
        "type": "field",
        "outboundTag": "direct",
        "ip": [
          "geoip:private",
          "geoip:cn"
        ],
        "enabled": true
      },
      {
        "type": "field",
        "port": "0-65535",
        "outboundTag": "proxy",
        "enabled": true
      }
    ]
  }
```

[Domain strategy](https://www.v2ray.com/en/configuration/routing.html):

- "AsIs": Only use domain for routing. Default value.
- "IPIfNonMatch": When no rule matches current domain, V2Ray resolves it into IP addresses (A or AAAA records) and try all rules again.
  - If a domain has multiple IP addresses, V2Ray tries all of them.
  - The resolved IPs are only used for routing decisions, the traffic is still sent to original domain address.
- "IPOnDemand": As long as there is a IP-based rule, V2Ray resolves the domain into IP immediately.

### guiNConfig.json

```
  "routings": [
    {
      "remarks": "仅大陆直连",
      "url": "",
      "rules": [
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "block",
          "ip": null,
          "domain": [
            "geosite:category-ads-all"
          ],
          "protocol": null,
          "enabled": true
        },
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "direct",
          "ip": null,
          "domain": [
            "geosite:cn"
          ],
          "protocol": null,
          "enabled": true
        },
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "direct",
          "ip": [
            "geoip:private",
            "geoip:cn"
          ],
          "domain": null,
          "protocol": null,
          "enabled": true
        },
        {
          "type": null,
          "port": "0-65535",
          "inboundTag": null,
          "outboundTag": "proxy",
          "ip": null,
          "domain": null,
          "protocol": null,
          "enabled": true
        }
      ],
      "enabled": true,
      "locked": false,
      "customIcon": ""
    },
    {
      "remarks": "仅防火墙代理",
      "url": "",
      "rules": [
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "direct",
          "ip": null,
          "domain": null,
          "protocol": [
            "bittorrent"
          ],
          "enabled": true
        },
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "block",
          "ip": null,
          "domain": [
            "geosite:category-ads-all"
          ],
          "protocol": null,
          "enabled": true
        },
        {
          "type": null,
          "port": null,
          "inboundTag": null,
          "outboundTag": "proxy",
          "ip": [
            "geoip:telegram"
          ],
          "domain": [
            "geosite:gfw",
            "geosite:greatfire",
            "geosite:tld-!cn"
          ],
          "protocol": null,
          "enabled": true
        },
        {
          "type": null,
          "port": "0-65535",
          "inboundTag": null,
          "outboundTag": "direct",
          "ip": null,
          "domain": null,
          "protocol": null,
          "enabled": true
        }
      ],
      "enabled": true,
      "locked": false,
      "customIcon": ""
    },
    {
      "remarks": "全局代理",
      "url": "",
      "rules": [
        {
          "type": null,
          "port": "0-65535",
          "inboundTag": null,
          "outboundTag": "proxy",
          "ip": null,
          "domain": null,
          "protocol": null,
          "enabled": true
        }
      ],
      "enabled": true,
      "locked": false,
      "customIcon": ""
    }
  ]
```
