# export TERM="xterm-256color"

# https://github.com/zplug/zplug
source ~/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
# zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Can manage everything e.g., other person's zshrc
# zplug "tcnksm/docker-alias", use:zshrc

# prezto plugins
# (https://github.com/sorin-ionescu/prezto)
zplug "modules/environment", from:prezto

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# prezto init
if [[ -e "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias (general)
alias ls="exa"
alias la="exa -la"
alias as="/usr/local/android-studio/bin/studio.sh"
alias vim="nvim"

# env
export LIBTORCH=~/libtorch
export LD_LIBRARY_PATH=/usr/local/lib:${LIBTORCH}/lib:$LD_LIBRARY_PATH

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# zoxide
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Vector(https://vector.dev/docs/setup/quickstart/)
alias run-vector="docker run -i -v $(pwd)/vector.toml:/etc/vector/vector.toml --rm timberio/vector:0.21.2-distroless-libc"
alias aws="/usr/local/bin/aws"

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
