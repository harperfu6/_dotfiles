#!/bin/bash
# Ubuntuで最新のnodeをインストールするためにはデフォルトのインストール先を変えてあげる必要がある

# 依存パッケージ
sudo apt install build-essential

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# set nodejs version
nvm install 16.14.2

# tell Ubuntu that we want to install the Nodejs package from nodesource.
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# install latest npm
npm install -g npm@latest
