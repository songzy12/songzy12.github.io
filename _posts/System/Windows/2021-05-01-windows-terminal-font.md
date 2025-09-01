---
layout: post
title: "Windows Terminal Font"
date: 2021-05-01T14:08:18+08:00
---

Fixing font/color issue I came across when using Windows terminals.

## Powerline Fonts

<https://github.com/microsoft/WSL/issues/1517>

<https://github.com/powerline/fonts>

```
/c/Users/songzy/.local/share/fonts/ -> C:\Windows\Fonts
```

`DejaVu Sans Mono for Powerline`.

## Add Fonts to Registry

This will affect what fonts are avaliable in cmd properties menu.

<https://www.maketecheasier.com/add-custom-fonts-command-prompt-windows10/>

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont
```

## tmux reset font

<https://github.com/microsoft/WSL/issues/3988>

### CodePage

<https://ss64.com/nt/chcp.html>

This will influence the behaviors of tmux, vim, cmd, powershell, etc.

#### 437

1. Open `regedit`.
2. Find this. `HKEY_CURRENT_USER\Console\C:_Program Files_WindowsApps_CanonicalGroupLimited.Ubuntu20.04onWindows_2004.2020.812.0_x64__79rhkp1fndgsc_ubuntu2004.exe`.
3. then, add CodePage (Type: DWORD, Value: 0x01b5).

#### 65001

<https://superuser.com/questions/269818/change-default-code-page-of-windows-console-to-utf-8>

`Language settings` -> `Administrative language settings` -> `Change system locale...` -> `Beta: Use Unicode UTF-8 for worldwide language support`.

## PowerShell reset font

PowerShell reset font to `raster` instead of using `consolas` as configured.

<https://github.com/microsoft/terminal/issues/280>

## Reference 

* https://en.wikipedia.org/wiki/DejaVu_fonts
* https://en.wikipedia.org/wiki/Code_page_437
