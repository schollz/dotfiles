#!/bin/bash

rm -rf ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > ~/.vim/colors/molokai.vim
curl https://raw.githubusercontent.com/schollz/dotfiles/main/vimrc > ~/.vimrc

## better ls colors
curl https://raw.githubusercontent.com/schollz/dotfiles/main/dircolors.monokai > /tmp/dircolors.monokai
dircolors /tmp/dircolors.monokai >> ~/.zshrc

## lua stuff
curl https://raw.githubusercontent.com/schollz/LuaFormat/master/lua-format.py >  ~/.config/lua-format.py
