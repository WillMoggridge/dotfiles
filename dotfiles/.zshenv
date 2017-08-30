. $HOME/.dotfiles/libs/common

export LC_ALL="en_GB.UTF-8"

WORKON_HOME=~/.virtualenvs
GOPATH="$HOME/.local/share/go"

# Add extra paths
export PATH=$GOPATH/bin:$PATH
if [ -d $HOME/.cargo/bin ]; then export PATH=$HOME/.cargo/bin:$PATH; fi
if [ -d $HOME/.local/share/umake/bin ]; then export PATH=$HOME/.local/share/umake/bin:$PATH; fi
if [ -d $HOME/.tmuxifier/bin ]; then export PATH=$HOME/.tmuxifier/bin:$PATH; fi
if [ -d $HOME/.dotfiles/bin ]; then export PATH=$HOME/.dotfiles/bin:$PATH; fi
if [ -d $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi
if [ -d $HOME/.local/bin ]; then export PATH=$HOME/.local/bin:$PATH; fi

# Load up env settings and aliases
autoload -U compinit && compinit
fpath=($HOME/.zsh/completions $fpath)
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.canonistack/novarc ]; then source $HOME/.canonistack/novarc; fi
if [ -f $HOME/.local_envs ]; then source $HOME/.local_envs; fi
if [ -f $HOME/.torch/install/bin/torch-activate ]; \
    then source $HOME/.torch/install/bin/torch-activate; fi

if cmd_exists kubeadm; then . <(kubeadm completion zsh); fi
if cmd_exists kubectl; then . <(kubectl completion zsh); fi

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"; fi

if cmd_exists nvim; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# Set default Juju location for dev
export JUJU_REPOSITORY=$HOME/dev/juju-charms

# Add Gnome Keyring as the SSH auth if we are in i3
if [[ $DESKTOP_SESSION = "i3" ]]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_CONTROL GNOME_KEYRING_PID
    export SSH_AGENT_PID=$GNOME_KEYRING_PID
fi

# Node/Ruby/Python Version Manager
# nvm
export PATH="$HOME/.npm-packages/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if cmd_exists pyenv; then
    # initialize pyenv
    eval "$(pyenv init -)"
    # initialize pyenv virtualenv
    eval "$(pyenv virtualenv-init -)"
fi
export rvm_silence_path_mismatch_check_flag=1
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.rvm/bin:$PATH"

# Load directory .envrc with direnv
if cmd_exists direnv; then
    eval "$(direnv hook zsh)"
fi
