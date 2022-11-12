#!/bin/bash

sudo apt install -y zsh vim htop pv git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.vim/pack/plugins/start
git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > ~/.vim/colors/molokai.vim
curl https://raw.githubusercontent.com/schollz/dotfiles/master/vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/schollz/dotfiles/master/dircolors.monokai > /tmp/dircolors.monokai
curl https://raw.githubusercontent.com/schollz/dotfiles/master/.zshrc > ~/.zshrc
# dircolors /tmp/dircolors.monokai >> ~/.zshrc

## install croc
curl https://getcroc.schollz.com | bash
