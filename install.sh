#!/bin/bash

sudo apt install -y zsh vim git clang-format wget curl python3

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

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
curl https://raw.githubusercontent.com/schollz/dotfiles/main/dircolors.monokai > ~/.vim/colors/molokai.vim
curl https://raw.githubusercontent.com/schollz/dotfiles/master/vimrc > ~/.vimrc
## markdown stuff
cd ~/.vim && wget https://github.com/preservim/vim-markdown/archive/master.tar.gz && tar --strip=1 -zxf master.tar.gz && rm -rf master.tar.gz


# install croc
curl https://getcroc.schollz.com | bash

# install torrenter
curl https://gettorrenter.schollz.com | bash

# install node 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.zshrc
nvm install 22
node -v
npm -v

# install go 
curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer && rm go_installer

