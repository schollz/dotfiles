#!/bin/bash

sudo apt install -y zsh vim git clang-format

# add zsrhc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl https://raw.githubusercontent.com/schollz/dotfiles/master/zshrc > ~/.zshrc
source ~/.zshrc

# add lua support
mkdir -p ~/.config
curl https://raw.githubusercontent.com/schollz/LuaFormat/master/lua-format.py >  ~/.config/lua-format.py

# improve vim
mkdir -p ~/.vim/pack/plugins/start
git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > ~/.vim/colors/molokai.vim
curl https://raw.githubusercontent.com/schollz/dotfiles/master/vimrc > ~/.vimrc

## install croc
curl https://getcroc.schollz.com | bash

