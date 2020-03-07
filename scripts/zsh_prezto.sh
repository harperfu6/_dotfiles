#! /bin/zsh

# prezto (instantly awesome zsh)
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# make symlink except .zshrc
setopt EXTENDED_GLOB # for use ^ syntax
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  # use my own zshrc
  if [ $rcfile != "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]; then
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  fi
done