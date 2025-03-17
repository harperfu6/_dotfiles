#! /bin/zsh

# Install tpm
git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm

# Install tmux-powerline
git clone https://github.com/erikw/tmux-powerline.git "$HOME"/.tmux/tmux-powerline

# link shell script
ln -sfnv "$HOME"/_dotfiles/.tmux/popup.sh "$HOME"/.tmux/popup.sh