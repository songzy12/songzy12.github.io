---
layout: post
title: "Workspace Setup"
date: 2020-12-13T16:29:08+08:00
---

This shows what we need to do when we move to a brand new Linux environment.

## wget proxy

```
vi ~/.wgetrc
```

```
http_proxy = http://localhost:1081
https_proxy = http://localhost:1081
```

## oh my zsh

Project link: <https://github.com/ohmyzsh/ohmyzsh>

Install script: <https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh>

Download and run the script:

```
sudo apt install zsh

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
```

## tmux config

```
vi ~/.tmux.conf
```

```
set -g default-shell /usr/bin/zsh
```

## apt source

Project link: <https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/>

```
vi /etc/apt/sources.list
```

```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
```

## python 

### pip source

```
sudo apt install python3-pip
```

<https://pip.pypa.io/en/stable/user_guide/#config-file>
<https://gist.github.com/MaHu6/228fe96b2b81c677ae5c950a6b8d55c4>

```
mkdir ~/.pip

echo "[global]" > ~/.pip/pip.conf
echo "  index-url = https://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf
echo "[install]" >> ~/.pip/pip.conf
echo "  trusted-host=mirrors.aliyun.com" >> ~/.pip/pip.conf
echo "" >> ~/.pip/pip.conf
```

### jupyter notebook

```
jupyter notebook --generate-config
vi ~/.jupyter/jupyter_notebook_config.py
```

```
c.NotebookApp.use_redirect_file = False
```

### virtualenvwrapper

<https://virtualenvwrapper.readthedocs.io/en/latest/install.html>

```
pip install virtualenvwrapper
```

```
vi ~/.bashrc
```

```
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```

## git config

### vim editor

```
git config --global core.editor "vim"
```

### proxy 

<https://gist.github.com/evantoli/f8c23a37eb3558ab8765>

```
git config --global http.proxy localhost:1081
```

### user 

```
git config --global user.email "songzy_thu@163.com"
git config --global user.name "Zhengyang Song"
```

## nodejs

### nvm

```
wget -qO- 
https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

```
nvm ls
nvm ls-remote
```

```
nvm install 
```

### npm source

<https://developer.aliyun.com/mirror/NPM>

```
npm config set registry https://registry.npm.taobao.org
```