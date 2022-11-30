#!/bin/zsh

# synbolic link for nvim
ln -sfnv "$DOTPATH"/config/nvim "$DOTPATH"/nvim
alias vim='nvim' # 'vim' command alias to 'nvim'

if [ ! -e $HOME/.config ]; then
	cd $HOME
	mkdir $HOME/.config
fi
# synbolic link for nvim config
ln -sfnv ~/_dotfiles/config/nvim ~/.config/nvim

# Install vim-plug (https://github.com/junegunn/vim-plug)
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
