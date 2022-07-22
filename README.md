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
