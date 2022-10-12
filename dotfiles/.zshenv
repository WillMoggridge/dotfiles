. $HOME/.dotfiles/libs/common

export LC_ALL="en_GB.UTF-8"

export WORKON_HOME=~/.virtualenvs
export GOPATH="$HOME/.go"

export ZSH_EVALCACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh-evalcache"

export EDITOR='kak'
export VISUAL="$EDITOR"

export XKB_DEFAULT_LAYOUT="gb"
export XKB_DEFAULT_VARIANT=""

# Define terminal for i3
export TERMINAL=kitty
# export TERM=xterm-256color

# Add extra paths
if [ -d /usr/local/go/bin ]; then export PATH=/usr/local/go/bin:$PATH; fi
if [ -d $HOME/.go/bin ]; then export PATH=$HOME/.go/bin:$PATH; fi
if [ -d $HOME/.cargo/bin ]; then export PATH=$HOME/.cargo/bin:$PATH; fi
if [ -d $HOME/.yarn/bin ]; then export PATH=$HOME/.yarn/bin:$PATH; fi
if [ -d $HOME/.local/share/umake/bin ]; then export PATH=$HOME/.local/share/umake/bin:$PATH; fi
if [ -d $HOME/.SpaceVim/bin ]; then export PATH=$HOME/.SpaceVim/bin:$PATH; fi
if [ -d $HOME/.tmuxifier/bin ]; then export PATH=$HOME/.tmuxifier/bin:$PATH; fi
if [ -d $HOME/.dotfiles/bin ]; then export PATH=$HOME/.dotfiles/bin:$PATH; fi
if [ -d $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi
if [ -d $HOME/.local/bin ]; then export PATH=$HOME/.local/bin:$PATH; fi
if [ -d $HOME/.pyenv/shims ]; then export PATH=$HOME/.pyenv/shims:$PATH; fi

source <(antibody init)
# Cache eval functions
antibody bundle mroth/evalcache

# Load up env settings and aliases
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.canonistack/novarc ]; then source $HOME/.canonistack/novarc; fi
if [ -f $HOME/.local_envs ]; then source $HOME/.local_envs; fi
if [ -f $HOME/.torch/install/bin/torch-activate ]; \
    then source $HOME/.torch/install/bin/torch-activate; fi

if cmd_exists 'kubeadm'; then . <(kubeadm completion zsh); fi
if cmd_exists 'kubectl'; then . <(kubectl completion zsh); fi
if cmd_exists 'minikube'; then . <(minikube completion zsh); fi

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"; fi

# Add Gnome Keyring as the SSH auth if we are in i3
if [[ $DESKTOP_SESSION = "i3" ]]; then
    _evalcache gnome-keyring-daemon --start
    export SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_CONTROL GNOME_KEYRING_PID
    export SSH_AGENT_PID=$GNOME_KEYRING_PID
fi
if [[ $DESKTOP_SESSION = "sway"* ]]; then
    export XDG_CURRENT_DESKTOP="sway"
    export _JAVA_AWT_WM_NONREPARENTING=1
    export MOZ_ENABLE_WAYLAND=1

    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_CONTROL GNOME_KEYRING_PID
    export SSH_AGENT_PID=$GNOME_KEYRING_PID
fi

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
fi

export NIX_PATH="${HOME}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
if [ -d "${HOME}/.nix-profile" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh"
    export PATH="${HOME}/.nix-profile/bin:${PATH}"
    export XDG_DATA_DIRS="${HOME}/.nix-profile/share:$XDG_DATA_DIRS"
fi

# Node/Ruby/Python Version Manager
# nvm
# export PATH="$HOME/.npm-packages/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
source <(antibody init)
export NVM_LAZY_LOAD=true
antibody bundle lukechilds/zsh-nvm
# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if cmd_exists 'pyenv'; then
    # initialize pyenv
    _evalcache pyenv init -
    # initialize pyenv virtualenv
    _evalcache pyenv virtualenv-init -
fi
PIPX_DEFAULT_PYTHON="$(pyenv prefix pipx)/bin/python"
export PIPX_DEFAULT_PYTHON
export rvm_silence_path_mismatch_check_flag=1
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.rvm/bin:$PATH"

# Load directory .envrc with direnv
if cmd_exists 'direnv'; then
    _evalcache direnv hook zsh
fi
