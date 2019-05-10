#!/bin/bash

## Install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
#sh ./installer.sh ~/.cache/dein
sh ./installer.sh "$DOTPATH"/.vim
rm installer.sh

#ln -sfnv "$DOTPATH"/.vimrc "$HOME"/.config/nvim/init.vim
ln -sfnv "$DOTPATH"/.vimrc "$HOME"/.vimrc
