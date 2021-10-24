---
layout: post
title: "Vim Command"
date: 2018-11-18 14:45:00 +0800
comments: true
categories: 

---

## syntax

```
cd /usr/share/vim/vim74/syntax 
vi python.vim
```

```
syn keyword pythonTodo      FIXME NOTE NOTES TODO XXX contained
```



```
$ ls ~/.vim/
ftdetect  ftplugin  indent  syntax
```

## color

```
ls /usr/share/vim/vim74/colors/
vi ~/.vimrc
color default
```

## |

`80|` should get you to position 80 in that line.

## d

```
dG 删除直到工作缓存区结尾的内容
d1G 删除直到工作缓存区开始的内容
```

删除第9行到第200行的内容(先用200G转到第200行) ，使用

```
:9,.d
```

## e

重新加载

```
:e
```

## J

合并行

In command mode:

```
[range]j[lines]
```

here you want to do the whole buffer:

```
%j
```

If you just wanted to do 10 lines from the current cursor position:

```
j10
```

If you dont want to replace the new lines with spaces use ! after j.

```
%j!
j!10
```

And for the uberfancy:

```
5j20
```

Would go to line 5, and join the next 20 lines.

## ret 

`set tabstop=4`: set the tabs to display as four spaces. 
`set expandtab`: insert spaces for tabs.
`ret`: replace tab

```
set expandtab
:%ret! 4
```

## s

```
:%s/源字符串/目的字符串/g
```

Add a string(`*`) to the end of each line in Vim:

```
:%s/$/\*/g
```

## set

* nu

```
set nu
set nonu
```

* paste

```
set paste
```

* invlist

```
set invlist
set nolist
```

## shell

```
ctrl+z 
fg
```

```
:!vim --version
```

```
:shell
```

## undo, redo

* `u`
* `ctrl+r`

## vsp

```
vim -On file1 file2 # 分屏启动Vim
:vsp filename # 分屏
Ctrl+w r # 滚动分屏
Ctrl+w = # 分屏宽度
```
