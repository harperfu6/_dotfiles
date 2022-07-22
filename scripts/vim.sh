#!/bin/zsh

# sysbolic link for nvim
ln -sfnv "$DOTPATH"/config/nvim "$DOTPATH"/nvim
alias vim='nvim' # 'vim' command alias to 'nvim'

# Install dein.vim (is a dark powered Vim/Neovim plugin manager)
# curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
#sh ./installer.sh ~/.cache/dein
#rm installer.sh

# Install vim-plug (https://github.com/junegunn/vim-plug)
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
