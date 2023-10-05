---
layout: post
title: "Workspace Setup"
date: 2023-04-22T16:29:08+08:00
---

This shows what we need to do when we move to a brand new Linux environment.

## apt

Project link: <https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/>

```
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

## wget

```
vi ~/.wgetrc
```

```
http_proxy=http://localhost:10809
https_proxy=http://localhost:10809
```

## git

### editor

```
git config --global core.editor "vim"
```

### proxy 

<https://gist.github.com/evantoli/f8c23a37eb3558ab8765>

```
git config --global http.proxy localhost:10809
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

## zsh

```
sudo apt install zsh
```

<https://github.com/ohmyzsh/ohmyzsh>

```
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

sh install.sh
```

<https://github.com/romkatv/powerlevel10k>

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`.

## tmux

```
vi ~/.tmux.conf
```

```
set -g default-shell /usr/bin/zsh
set -g default-terminal "xterm-256color"
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

```
sudo apt install virtualenv
```

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

## brew 

```
# 查看 brew.git 当前源
$ cd "$(brew --repo)" && git remote -v
origin    https://github.com/Homebrew/brew.git (fetch)
origin    https://github.com/Homebrew/brew.git (push)

# 查看 homebrew-core.git 当前源
$ cd "$(brew --repo homebrew/core)" && git remote -v
origin    https://github.com/Homebrew/homebrew-core.git (fetch)
origin    https://github.com/Homebrew/homebrew-core.git (push)
```

```
# 替换各个源
$ git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
$ git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
$ git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git

# zsh 替换 brew bintray 镜像
$ echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.zshrc
$ source ~/.zshrc

# 刷新源
$ brew update
```
