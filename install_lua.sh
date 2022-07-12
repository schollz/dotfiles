#!/bin/bash

sudo apt install -y lua5.3

curl https://raw.githubusercontent.com/schollz/LuaFormat/master/lua-format.py >  ~/.config/lua-format.py

echo "set autoread" >> ~/.vimrc
echo "autocmd BufWritePost *.lua silent! !python3 ~/.config/lua-format.py <afile>" >> ~/.vimrc
echo "autocmd BufWritePost *.lua redraw!" >> ~/.vimrc


