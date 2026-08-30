---
title: "Prevent WSL from Auto Closing"
date: 2026-08-30T10:00:00+08:00
categories: WSL
---

By default, WSL2 automatically terminates its virtual machine when all terminal sessions are closed or after being idle. To keep WSL running continuously in the background (for daemons, background services, Docker, or SSH), you can use the following methods.

## Configure `.wslconfig` (Recommended)

In Windows, create or edit `%USERPROFILE%\.wslconfig` (usually `C:\Users\<YourUsername>\.wslconfig`):

```ini
[wsl2]
vmIdleTimeout=-1
```

- `vmIdleTimeout=-1` sets the idle timeout to infinity, preventing WSL2 from shutting down automatically after closing terminal windows.
- To apply the changes, restart WSL in PowerShell/CMD:

```powershell
wsl --shutdown
```

## Helpful WSL Management Commands

- Check running status of WSL distributions:

```powershell
wsl --list --verbose
```

- Manually shut down WSL:

```powershell
wsl --shutdown
```
