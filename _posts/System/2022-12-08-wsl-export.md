---
layout: post
title: "WSL Export/Import"
date: 2022-12-08T22:11:00+08:00
---

WSL2 export and import.

```
PS C:\Users\songzy> wsl --list
Windows Subsystem for Linux Distributions:
Ubuntu-20.04 (Default)

PS C:\Users\songzy> wsl --export Ubuntu-20.04 D:/Ubuntu-20.04.tar

PS C:\Users\songzy> wsl --unregister Ubuntu-20.04
Unregistering...

PS C:\Users\songzy> wsl --import Ubuntu-20.04 D:/Ubuntu-20.04/ D:/Ubuntu-20.04.tar
```