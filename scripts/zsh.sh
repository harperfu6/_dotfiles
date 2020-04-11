#!/bin/bash

if [ "$PLATFORM" == 'mac' ]; then
  echo "Install zsh"
  brew install -y zsh
  brew install -y tmux

  echo "Install Powerline fonts"
  # Powerline fonts
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts

  echo "Install vim-gnome (for clipborad)"
  brew install -y vim-gnome

elif [ "$PLATFORM" == 'linux' ]; then
  if [ ! -z $(which yum) ]; then
    echo "Install zsh"
    sudo yum install -y zsh

    echo "Install Powerline fonts"
    # Powerline fonts
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts

    echo "Install tmux"
    sudo yum install -y tmux

    echo "Install chsh"
    sudo yum install -y util-linux-user

    echo "Install vim-gnome (for clipborad)"
    sudo yum vim-gnome

  elif [ ! -z $(which apt-get) ]; then
    echo "Install zsh"
    sudo apt install -y zsh
    echo "Install Powerline fonts"
    sudo apt install -y fonts-powerline
    echo "Install tmux"
    sudo apt install -y tmux
    echo "Install vim-gnome (for clipborad)"
    sudo apt install -y vim-gnome
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
