#!/bin/zsh

# Install dein.vim (is a dark powered Vim/Neovim plugin manager)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
rm installer.sh