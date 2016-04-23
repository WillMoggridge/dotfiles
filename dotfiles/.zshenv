source $HOME/.dotfiles/libs/common

WORKON_HOME=~/.virtualenvs

# Add extra paths
if [ -d $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi
if [ -d $HOME/.dotfiles/bin ]; then export PATH=$HOME/.dotfiles/bin:$PATH; fi
if [ -d $HOME/.local/bin ]; then export PATH=$HOME/.local/bin:$PATH; fi
if [ -d $HOME/.tmuxifier/bin ]; then export PATH=$HOME/.tmuxifier/bin:$PATH; fi

if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.canonistack/novarc ]; then source $HOME/.canonistack/novarc; fi
if [ -f $HOME/.local_envs ]; then source $HOME/.local_envs; fi
if [ -f $HOME/.torch/install/bin/torch-activate ]; \
    then source $HOME/.torch/install/bin/torch-activate; fi

# Node/Ruby Version Manager
export PATH="$PATH:$HOME/.npm-packages/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# If you don't put RVM last, YOU GET A WARNING. >=(
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.rvm/bin:$PATH"

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"; fi

if cmd_exists nvim; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# Add Gnome Keyring as the SSH auth if we are in i3
if [[ $DESKTOP_SESSION = "i3" ]]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_CONTROL GNOME_KEYRING_PID
    export SSH_AGENT_PID=$GNOME_KEYRING_PID
fi
