#!/bin/bash

if [ "$PLATFORM" == 'mac' ]; then
	echo "Install Homebrew"
	if [ -z "$(which brew)" ]; then
		yes ' ' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		(
			echo
			echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
		) >>$HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
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

	echo "Install Powerline fonts"
	# Powerline fonts
	git clone https://github.com/powerline/fonts.git --depth=1
	cd fonts
	./install.sh
	cd .. && rm -rf fonts

	echo "Install tmux"
	if [ -z "$(which tmux)" ]; then
		brew install tmux
	else
		echo "tmux is already installed"
	fi

	echo "Install neovim"
	brew install neovim

	echo "Install lazyvim"
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git

	echo "Install fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

	echo "Install zoxide"
	brew install zoxide

	echo "Install pyenv"
	curl https://pyenv.run | bash

	echo "Install ag"
	brew install the_silver_searcher

elif [ "$PLATFORM" == 'linux' ]; then
	if [ ! -z $(which yum) ]; then
		echo "Install zsh"
		sudo yum install -y zsh

		echo "Install Powerline fonts"
		# Powerline fonts
		git clone https://github.com/powerline/fonts.git --depth=1
		cd fonts
		./install.sh
		cd .. && rm -rf fonts

		echo "Install Nerd font (for lazyvim)"
		wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
		unzip JetBrainsMono.zip
		mv *.ttf ~/.local/share/fonts/

		echo "Install tmux"
		sudo yum -y libevent ncurses libevent-devel ncurses-devel gcc make bison pkg-config
		wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
		tar -zxf tmux-*.tar.gz
		cd tmux-*/
		./configure
		make && sudo make install
		rm -rf tmux-3.3a tmux-3.3a.tar.gz

		echo "Install chsh"
		sudo yum install -y util-linux-user

		echo "Install neovim"
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x nvim.appimage
		./nvim.appimage --appimage-extract
		./squashfs-root/AppRun --version
		sudo mv squashfs-root /
		sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
		rm nvim.appimage nvim.sh

		echo "Install lazyvim"
		git clone https://github.com/LazyVim/starter ~/.config/nvim
		rm -rf ~/.config/nvim/.git

		echo "Install fzf"
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install

		echo "Install zoxide"
		curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

		echo "Install pyenv"
		curl https://pyenv.run | bash

		echo "Install ag"
		yum install the_silver_searcher

	elif [ ! -z $(which apt-get) ]; then
		echo "Install zsh"
		sudo apt install -y zsh

		echo "Install Powerline fonts"
		sudo apt install -y fonts-powerline

		echo "Install tmux"
		sudo yum -y libevent ncurses libevent-devel ncurses-devel gcc make bison pkg-config
		wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
		tar -zxf tmux-*.tar.gz
		cd tmux-*/
		./configure
		make && sudo make install
		rm -rf tmux-3.3a tmux-3.3a.tar.gz

		echo "Install vim-gnome (for clipborad)"
		sudo apt install -y vim-gtk
		sudo apt autoremove

		echo "Install neovim"
		sudo apt install -y neovim

		echo "Install lazyvim"
		git clone https://github.com/LazyVim/starter ~/.config/nvim
		rm -rf ~/.config/nvim/.git

		echo "Install fzf"
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install

		echo "Install zoxide"
		curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

		echo "Install pyenv"
		curl https://pyenv.run | bash

		echo "Install ag"
		apt install the_silver_searcher

		echo "Install coreutils"
		brew install coreutils

	else
		echo "WARNING: zsh was not able to be installed."
	fi
fi

echo "Install exa (using cargo (which means installing Rust as well!!))"
curl https://sh.rustup.rs -sSf | sh
cargo install exa

echo "Install alacritty"
cargo install alacritty

echo "Install rigrep"
cargo install ripgrep

# もし/etc/shellsに，/bin/zshがなければteeで受け取り/追記する
if ! grep -q /bin/zsh /etc/shells; then
	echo "/bin/zsh" | sudo tee -a /etc/shells
fi

# zplug (plugin manager for zsh)
# $ZPLUG_HOME is set as ~/.zplug (https://github.com/zplug/installer/blob/master/installer.zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# install prezto (Instantly Awesome Zsh) as zsh
zsh "$DOTPATH"/scripts/zsh_prezto.sh
