#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
  PLATFORM='mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  PLATFORM='linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

export PLATFORM

# 環境変数DOTPATHが設定されていればそのまま使う
# DOTPATHは未宣言なので, NULLの場合は空で置換（初期化）しつつ宣言し，ifに入れる
if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=$(pwd -P) && export DOTPATH
fi

# cache sudo anthentication
sudo -v

bash "$DOTPATH"/scripts/zsh.sh
bash "$DOTPATH"/scripts/tmux.sh
bash "$DOTPATH"/scripts/vim.sh
