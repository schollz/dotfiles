#!/bin/bash

sudo apt update
sudo apt install -y zsh vim git clang-format wget curl python3

# add zsrhc
# check if .zshrc does not exist
if [ ! -f ~/.zshrc ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    curl https://raw.githubusercontent.com/schollz/dotfiles/master/zshrc > ~/.zshrc
fi
zsh 
source ~/.zshrc

# add lua support
if [ ! -f ~/.config/lua-format.py ]; then
    mkdir -p ~/.config
    curl -s https://raw.githubusercontent.com/schollz/LuaFormat/master/lua-format.py >  ~/.config/lua-format.py
fi

# improve vim
if [ ! -f ~/.vimrc ]; then
    mkdir -p ~/.vim/pack/plugins/start
    git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
    mkdir -p ~/.vim/colors
    curl -s https://raw.githubusercontent.com/schollz/dotfiles/main/dircolors.monokai > ~/.vim/colors/molokai.vim
    curl -s https://raw.githubusercontent.com/schollz/dotfiles/master/vimrc > ~/.vimrc
    ## markdown stuff
    cd ~/.vim && wget -q https://github.com/preservim/vim-markdown/archive/master.tar.gz && tar --strip=1 -zxf master.tar.gz && rm -rf master.tar.gz
    cd ~
fi

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install croc
curl -s https://getcroc.schollz.com | bash

# install torrenter
curl -s https://gettorrenter.schollz.com | bash

# install node 
if [ ! -f ~/.nvm/nvm.sh ]; then
    curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.zshrc
    nvm install 22
fi
node -v
npm -v

# install go 
arch="$(uname -m)"
if [[ "$arch" == *"aarch"* ]]; then
    url="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-arm64\.tar\.gz' | sed 's/^/https:\/\/golang.org\/dl\//g' | head -n 1)"
else
    url="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | sed 's/^/https:\/\/golang.org\/dl\//g' | head -n 1)"
fi
echo "downloading: ${url}"
wget --progress=bar:force --quiet "${url}" -O /tmp/go.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz
go version