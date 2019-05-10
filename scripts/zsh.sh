#!/bin/bash

if [ "$PLATFORM" == 'mac' ]; then
  brew install zsh
elif [ "$PLATFORM" == 'linux' ]; then
  if [ ! -z $(which yum) ]; then
    sudo yum install zsh
  elif [ ! -z $(which apt-get) ]; then
    sudo apt-get install zsh
  else
    echo "WARNING: zsh was not able to be installed."
  fi
fi

# zplug(plugin manager for zsh)
export ZPLUG_HOME=~/_dotfiles/.zsh/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

if ! grep -q /bin/zsh /etc/shells; then
  echo "/bin/zsh" | sudo tee -a /etc/shells
fi
