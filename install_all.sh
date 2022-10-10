#!/bin/bash

sudo apt install -y zsh vim htop pv git python3-pip cmake lua5.3
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.vim/pack/plugins/start
git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > ~/.vim/colors/molokai.vim
curl https://raw.githubusercontent.com/schollz/dotfiles/master/vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/schollz/dotfiles/master/dircolors.monokai > /tmp/dircolors.monokai
dircolors /tmp/dircolors.monokai >> ~/.zshrc

## install go
./install_go.sh
mkdir -p ~/go/src/github.com/schollz

## install node
./install_node.sh

## install croc
curl https://getcroc.schollz.com | bash

## update python
sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install tqdm numpy
