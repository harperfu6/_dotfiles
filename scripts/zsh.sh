#!/bin/bash

if [ "$PLATFORM" == 'mac' ]; then
  brew install zsh
elif [ "$PLATFORM" == 'linux' ]; then
  if [ ! -z $(which yum) ]; then
    sudo yum install zsh
  elif [ ! -z $(which apt-get) ]; then
    sudo apt install zsh
    sudo apt install fonts-powerline
    sudo apt install vim-gnome
    sudo apt autoremove
  else
    echo "WARNING: zsh was not able to be installed."
  fi
fi


# もし/etc/shellsに，/bin/zshがなければteeで受け取り/追記する
if ! grep -q /bin/zsh /etc/shells; then
  echo "/bin/zsh" | sudo tee -a /etc/shells
fi

# zplug (plugin manager for zsh)
# $ZPLUG_HOME is set as ~/.zplug (https://github.com/zplug/installer/blob/master/installer.zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# install prezto (Instantly Awesome Zsh) as zsh
zsh "$DOTPATH"/scripts/zsh_prezto.sh