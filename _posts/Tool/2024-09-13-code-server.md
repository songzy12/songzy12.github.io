---
layout: post
title: "Code Server"
date: 2024-09-13T21:56:16+08:00
---

How to install and use [Code Server](https://github.com/coder/code-server).

## Motivation

This way, we can put our project codes in **remote cloud machines**, and access it from a **browser** in **any other computers**.

NOTE: Without the "browser" requirement, you can use vscode directly to access files in remote cloud machine from any computers.

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

### Remote Host

https://coder.com/docs/code-server/guide#port-forwarding-via-ssh

```
# Replaces "auth: password" with "auth: none" in the code-server config.
sed -i.bak 's/auth: password/auth: none/' ~/.config/code-server/config.yaml
```

```
sudo service code-server@$USER status
```

### Local Client

```
set -x
ssh -N -L 8080:127.0.0.1:8080 songzy@maomaosenlin.cc
```

Then, you can visit http://localhost:8080 in your local machine to access the code server started in remote machine.

## Extensions

Some extensions are not avaliable in the default extension market, you might need to install them manually. Let us use the "C/C++" extension as an example.

First, find the extension download link from the "Version History" tab of the vscode extension marketplace: 
<https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools&ssr=false#version-history>

Then, in your remote machine, use wget to download the extension:

```
wget https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/cpptools/1.23.0/vspackage\?targetPlatform\=linux-x64
```

The file downloaded by `wget` (or `curl`) cannot be installed directly since it is in a gzip format. So we need to first rename it with suffix `.gz` and then `gunzip` it:

```
mv vspackage\?targetPlatform=linux-x64 ms-vscode.cpptools-1.10.3@linux-x64.vsix.gz
gunzip ms-vscode.cpptools-1.10.3@linux-x64.vsix.gz
```

Then, you can install the `ms-vscode.cpptools-1.10.3@linux-x64.vsix` either from commandline or search for the "Extensions: Install from VSIX" after typing "Shift-Command-P".

## Alternatives

- [vscode.dev](https://code.visualstudio.com/blogs/2021/10/20/vscode-dev): This is a lightweight vscode running in browser to manipulate **local** files.
- [GitHub Codespaces](https://github.com/features/codespaces): This is not free, and has network connection issue (you know it) from time to time.
