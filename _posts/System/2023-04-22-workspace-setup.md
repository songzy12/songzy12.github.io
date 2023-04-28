---
layout: post
title: "Workspace Setup"
date: 2023-04-22T16:29:08+08:00
---

This shows what we need to do when we move to a brand new Linux environment.

## wget

```
vi ~/.wgetrc
```

```
http_proxy = http://localhost:1081
https_proxy = http://localhost:1081
```

## zsh

Project link: <https://github.com/ohmyzsh/ohmyzsh>

Install script: <https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh>

Download and run the script:

```
sudo apt install zsh

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
```

## tmux

```
vi ~/.tmux.conf
```

```
set -g default-shell /usr/bin/zsh
set -g default-terminal "xterm-256color"
```

## apt

Project link: <https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/>

```
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

## git

### editor

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

### ssh https

```
vi ~/.ssh/config
```

```
Host github.com
  Hostname ssh.github.com
  Port 443
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

```
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
```

### virtualenvwrapper

<https://virtualenvwrapper.readthedocs.io/en/latest/install.html>

```
pip install virtualenvwrapper
```

```
# vi ~/.bashrc
vi ~/.zshrc
```

```
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh
source ~/.local/bin/virtualenvwrapper.sh
```

## nodejs

### nvm

<https://github.com/nvm-sh/nvm>

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

### npm registry

<https://developer.aliyun.com/mirror/NPM>

```
npm config get registry
npm config set registry https://registry.npm.taobao.org
```

### yarn registry

```
yarn config get registry
yarn config set registry https://registry.npm.taobao.org
```

## docker

```
mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```

```
sudo service docker restart
```

```
docker info
```

## vscode

`settings.json`

```
{
    "diffEditor.ignoreTrimWhitespace": false,
    "editor.inlineSuggest.enabled": true,
    "workbench.colorTheme": "Default Light+ Experimental",
    "window.commandCenter": true,
    "outline.showVariables": false,
    "scm.defaultViewMode": "tree",
    "terminal.integrated.defaultProfile.osx": "zsh",
    "terminal.integrated.fontFamily": "MesloLGS NF",
    "notebook.markup.fontSize": 14,
    "git.autofetch": true,
    "git.autoStash": true,
    "markdown.preview.doubleClickToSwitchToEditor": false,
    "python.formatting.provider": "yapf",
    "remote.SSH.remotePlatform": {
        "songzy.cool": "linux"
    },
}
```
