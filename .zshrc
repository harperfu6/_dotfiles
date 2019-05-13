# ENV
export TERM="xterm-256color"
## tex
# export PATH="/usr/local/opt/texinfo/bin:$PATH"
## powerlivel9k用（遅いのでやめた）
#POWERLEVEL9K_MODE='nerdfont-complete'


# source prezto
# Prezto is the configuration framework for Zsh; it enriches the command line interface environment with sane defaults, aliases, functions, auto completion, and prompt themes.
# (https://github.com/sorin-ionescu/prezto)
# 本来はprezto配下の.zshrcを読み込むようにするが，以下の処理しかしてないので，_dotfiles配下の.zshrcで編集できるよう以下の処理を追記
if [[ -s "$HOME/_dotfiles/.zsh/.zplug/repos/sorin-ionescu/prezto/init.zsh" ]]; then
  source "$HOME/_dotfiles/.zsh/.zplug/repos/sorin-ionescu/prezto/init.zsh"
fi

#export ZPLUG_HOME=~/_dotfiles/.zsh/.zplug
#source $ZPLUG_HOME/init.zsh

# export PATH="$HOME/.pyenv/shims:$PATH"
# 
# # peco(インクリメンタルサーチ) for zsh
# zplug "mollifier/anyframe"
# 
# # gitルートへ一発でcdできる
# # zplug "mollifier/cd-gitroot"
# 
# # history関係
# # zplug "zsh-users/zsh-history-substring-search"
# 
# # 補完
# # zplug "zsh-users/zsh-completions"

#prezto
zplug "sorin-ionescu/prezto"
# prezto plugins
zplug "modules/prompt", from:prezto


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load



#alias
alias sp3='source ~/study/python/py36/env/bin/activate'
alias sp27='source ~/SenseTest/py27/bin/activate'
alias da='deactivate'

# tmux
# (tmux)シェルログイン時に自動的にアタッチ(https://qiita.com/b4b4r07/items/01359e8a3066d1c37edc)
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                rejd
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
