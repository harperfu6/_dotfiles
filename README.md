## install
-----
```
$ cd _dotfiles/
$ make install

# If ~/.zshrc is not existed, make link manually.
$ make link
```

## chsh (optional)
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

## Install plugins
### zplug
restart zsh then install automatically

### vim
```
$ vim
:PlugInstall
```
### tmux
```
$ tmux
$ Prefix + I
```

