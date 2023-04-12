#!/bin/zsh

if (( $(uname) == "Darwin" )); then
  PLATFORM="mac"
elif (( $(expr substr $(uname -s) 1 5) == "Linux" )); then
  PLATFORM="linux"
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

if (( $PLATFORM == "mac" )); then
	# nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	source ~/.zshrc # add nvm path to PATH
	nvm install --lts

	nvm install node
	
	# install latest npm
	npm install -g npm@latest

	# install yarn
	npm install -g yarn

elif (( $PLATFORM == "linux" )); then
  if (( ! -z $(which yum) )); then
		# nvm
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
		source ~/.zshrc # add nvm path to PATH
		nvm install --lts # install nodejs / npm
		
		# add repository.
		curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
		sudo yum install -y nodejs
		
		# install latest npm
		npm install -g npm@latest

		# install yarn
		npm install -g yarn

	elif (( ! -z $(which apt-get) )); then
		# Ubuntuで最新のnodeをインストールするためにはデフォルトのインストール先を変えてあげる必要がある
		# 依存パッケージ
		sudo apt install build-essential
		
		# nvm
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
		# source ~/.zshrc # add nvm path to PATH
		nvm install --lts # install nodejs / npm
		
		# add repository.
		curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
		sudo apt-get install -y nodejs
		
		# install latest npm
		npm install -g npm@latest

		# install yarn
		npm install -g yarn

	else
		echo "Unsupported PLATFORM"
	fi
else
	echo "PLATFORM ENV is unset!"
fi
