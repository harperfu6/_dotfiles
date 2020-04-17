# Installation
## preparation (Mac)
-----
```
# for xcrun: erros: invalid acrive developer path...
xcode-select --install
```

## install
-----
```
$ cd _dotfiles/
$ make install

# If make link is not run (~/.zshrc is not existed), call it manually.
$ make link
```

## chsh
-----
```
# Ubuntu
$ chsh -s $(which zsh)

# Linux (AWS EC2)
$ sudo su
$ chsh ec2-user
Changing shell for ec2-user.
New shell [/bin/bash]: /usr/bin/zsh
Shell changed.
$ exit
```

## logout
```
$ exit
```

# vimrc (option)
## vimrc clipboard for Mac
fix the following for Mac
```
set clipboard=unnamedplus         " クリップボードを有効にする(for ubuntu)
"set clipboard+=unnamed         " クリップボードを有効にする(for mac)
↓
"set clipboard=unnamedplus         " クリップボードを有効にする(for ubuntu)
set clipboard+=unnamed         " クリップボードを有効にする(for mac)
```

## vimrc reload
If vim is not updated after you update vimrc, try the following.
- comment the rc file
- run vim
- uncomment the rc file
- run vim
