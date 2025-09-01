---
layout: post
title: "V2Ray Client - Mac"
date: 2024-08-13T22:28:17+08:00
---

How to resolve: "V2rayU"将对你的电脑造成伤害

<https://discussionschinese.apple.com/thread/254968153>

证书过期问题导致的：

第一步，执行
```
sudo codesign --force --deep --sign - /Applications/V2rayU.app
```

第二步，在应用程序中找到V2rayU，右键，显示简介，勾选覆盖恶意软件保护

第三步，打开软件

第四步，执行
```
sudo codesign --force --deep --sign - ~/.V2rayU/V2rayUTool
sudo codesign --force --deep --sign - ~/.V2rayU/v2ray-core/v2ray
```

然后就能正常运行了。
