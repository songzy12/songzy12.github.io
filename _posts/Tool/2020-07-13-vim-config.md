---
layout: post
title: "Vim Config"
date: 2020-07-13T21:18:08+08:00
---

## .vimrc

```
set ignorecase 
set hlsearch
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set cursorline
set autoindent
set smartindent
set scrolloff=4
set showmatch
set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set fileformat=unix

colorscheme desert

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'Chiel92/vim-autoformat'
nnoremap <F6> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

## vundle

<https://github.com/VundleVim/Vundle.vim>

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
```

Put this in your `.vimrc`.

```
Plugin 'Chiel92/vim-autoformat'
```

Then restart vim and run `:PluginInstall`.

注意这里 autoformat 要对 Python 起作用的话还要安装 autopep8:

```
pip install autopep8
```
