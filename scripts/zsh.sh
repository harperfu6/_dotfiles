#!/bin/bash

if [ "$PLATFORM" == 'mac' ]; then
  echo "Install Homebrew"
  if [ -z "$(which brew)" ]; then
    yes ' ' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Homebrew is already installed"
  fi

  echo "Install zsh"
  if [ -z "$(which zsh)" ]; then
    brew install zsh
  else
    echo "ReInstall zsh (for libgdbm.4.dylib)"
    brew reinstall zsh && brew unlink zsh && brew link zsh
  fi

  echo "Install tmux"
  if [ -z "$(which tmux)" ]; then
    brew install tmux
  else
    echo "tmux is already installed"
  fi

  echo "Install Powerline fonts"
  # Powerline fonts
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts

  echo "Install vim (for clipborad)"
  brew install vim
  #sudo mv /usr/bin/vim /usr/bin/old_vim
  #sudo ln /usr/local/Cellar/vim/*/bin/vim /usr/bin

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

    #echo "Install vim (for clipborad)"
    #sudo yum install -y mercurial ncurses-devel gcc gtk2 gtk2-devel xorg-x11-server-devel
    #sudo yum-builddep vim-X11
    #sudo yum -y groupinstall "X Window System"
    #cd /usr/local/src
    #sudo hg clone https://bitbucket.org/vim-mirror/vim vim
    #cd vim

    #rm -f src/auto/config.cache

    #sudo ./configure --with-features=huge \
    # --enable-multibyte \
    # --enable-gpm \
    # --enable-cscope \
    # --enable-fontset \
    # --enable-fail-if-missing \
    # --enable-pythoninterp=dynamic \
    # --enable-python3interp=dynamic \
    # --enable-rubyinterp=dynamic \
    # --enable-gui=auto \
    # --enable-gtk2-check \
    # --with-x 

    #make
    #sudo make install

    #cd "$DOTPATH"

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
