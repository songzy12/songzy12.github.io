---
layout: post
title: "Tencent Cloud"
date: 2022-01-13T20:46:54+08:00
---

How to config SSH of tencent cloud.

## Config Files for Client & Server 

For OpenSSH, the SSH client user configuration file is named **config**, and the SSH client system-wide configuration file is named **ssh_config**. The files reside at the following locations:

- User configuration file location: `$HOME/.ssh/config`
- System-wide configuration file default location: `/etc/ssh/ssh_config`

An SSH client obtains its configurations from **the ssh command-line options**, **the user configuration file**, and **the system-wide configuration file**, in that order. For each parameter, the SSH client uses the first obtained value for that parameter.

The SSH server has its own set of configuration files, including the SSH server system-wide configuration file named **sshd_config**. By default, these files reside in the `/etc/ssh` directory on the remote host.

## GSSAPIAuthentication

```
sudo vi /etc/ssh/ssh_config

GSSAPIAuthentication no
```

## IO util

> 该实例云硬盘「disk-12z41atd」的io_util已达100%，请关注磁盘业务情况。可参考文档：点击查看

<https://cloud.tencent.com/document/product/213/57337#.E7.A1.AC.E7.9B.98-.25util-.E9.AB.98>

> 硬盘 %util 高
> 
> 故障现象：实例卡顿，使用 SSH 或 VNC 登录慢或无响应。
> 
> 可能原因：IO 高导致硬盘 %util 达到100%。
> 
> 处理步骤：查看 IO 高是否合理，且需评估是否减少 IO 读写或者置换更高性能的硬盘。