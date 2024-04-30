---
layout: post
title: "Windows Env Var"
date: 2022-12-09T14:02:27+08:00
---

Built-in envrionment variables on Windows.

https://en.wikipedia.org/wiki/Environment_variable#Windows

| Variable | Locale specific | Windows XP (CMD) | Windows Vista and later (CMD) |
|:---:|:---:|:---:|:---:|
| %ALLUSERSPROFILE% | Yes | C:\Documents and Settings\All Users | C:\ProgramData |
| %APPDATA% | Yes | C:\Documents and Settings\{username}\Application Data | C:\Users\{username}\AppData\Roaming |
| %CommonProgramFiles% | Yes | C:\Program Files\Common Files | C:\Program Files\Common Files |
| %CommonProgramFiles(x86)% | Yes | C:\Program Files (x86)\Common Files (only in 64-bit version) | C:\Program Files (x86)\Common Files (only in 64-bit version) |
| %CommonProgramW6432% | Yes | %CommonProgramW6432% (not supported, not replaced by any value) | C:\Program Files\Common Files (only in 64-bit version) |
| %COMPUTERNAME% | No | {computername} | {computername} |
| %ComSpec% | No | C:\Windows\System32\cmd.exe | C:\Windows\System32\cmd.exe |
| %HOMEDRIVE% | No | C: | C: |
| %HOMEPATH% | Yes | \Documents and Settings\{username} | \Users\{username} |
| %LOCALAPPDATA% | Yes | %LOCALAPPDATA% (not supported, not replaced by any value) | C:\Users\{username}\AppData\Local |
| %LOGONSERVER% | No | \\{domain_logon_server} | \\{domain_logon_server} |
| %PATH% | Yes | C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;{plus program paths} | C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;{plus program paths} |
| %PATHEXT% | No | .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.WSF;.WSH | .com;.exe;.bat;.cmd;.vbs;.vbe;.js;.jse;.wsf;.wsh;.msc |
| %ProgramData% | Yes | %ProgramData% (not supported, not replaced by any value) | %SystemDrive%\ProgramData |
| %ProgramFiles% | Yes | %SystemDrive%\Program Files | %SystemDrive%\Program Files |
| %ProgramFiles(x86)% | Yes | %SystemDrive%\Program Files (x86) (only in 64-bit version) | %SystemDrive%\Program Files (x86) (only in 64-bit version) |
| %ProgramW6432% | Yes | %ProgramW6432% (not supported, not replaced by any value) | %SystemDrive%\Program Files (only in 64-bit version) |
| %PROMPT% | No | Code for current command prompt format, usually $P$G | Code for current command prompt format, usually $P$G |
| %PSModulePath% |  | %PSModulePath% (not supported, not replaced by any value) | %SystemRoot%\system32\WindowsPowerShell\v1.0\Modules\ |
| %PUBLIC% | Yes | %PUBLIC% (not supported, not replaced by any value) | %SystemDrive%\Users\Public |
| %SystemDrive% | No | C: | C: |
| %SystemRoot% | No | The Windows directory, usually C:\Windows, formerly C:\WINNT | %SystemDrive%\Windows |
| %TEMP% and %TMP% | Yes | %SystemDrive%\Documents and Settings\{username}\Local Settings\Temp | %SystemRoot%\TEMP (for system environment variables %TMP% and %TEMP%), %USERPROFILE%\AppData\Local\Temp (for user environment variables %TMP% and %TEMP%) |
| %USERDOMAIN% | No | {userdomain} | {userdomain} |
| %USERNAME% | No | {username} | {username} |
| %USERPROFILE% | Yes | %SystemDrive%\Documents and Settings\{username} | %SystemDrive%\Users\{username} |
| %windir% | No | %SystemDrive%\WINDOWS | %SystemDrive%\Windows |
