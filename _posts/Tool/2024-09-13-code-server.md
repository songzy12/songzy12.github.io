---
layout: post
title: "Code Server"
date: 2024-09-13T21:56:16+08:00
---

How to install and use [Code Server](https://github.com/coder/code-server).

## Install

https://coder.com/docs/code-server/install#debian-ubuntu

```
export VERSION=4.92.2
curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb
```

```
sudo dpkg -i code-server_${VERSION}_amd64.deb
```

```
sudo systemctl enable --now code-server@$USER
# Now visit http://127.0.0.1:8080. Your password is in ~/.config/code-server/config.yaml
```

## SSH Port Forwarding

https://coder.com/docs/code-server/guide#port-forwarding-via-ssh

```
# Replaces "auth: password" with "auth: none" in the code-server config.
sed -i.bak 's/auth: password/auth: none/' ~/.config/code-server/config.yaml
```

```
sudo service code-server@$USER status
```

### Local Machine

```
set -x
ssh -N -L 8080:127.0.0.1:8080 songzy@maomaosenlin.cc
```

Then, you can visit http://localhost:8080 in your local machine to access the code server started in remote machine.
