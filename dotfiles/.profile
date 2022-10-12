# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

WORKON_HOME=~/.virtualenvs

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# SpaceVim config directory
export SPACEVIMDIR="$HOME/.config/SpaceVim.d"

GOPATH="$HOME/.local/share/go"

# Add extra paths
export PATH=$GOPATH/bin:$PATH
if [ -d $HOME/.cargo/bin ]; then export PATH=$HOME/.cargo/bin:$PATH; fi
if [ -d $HOME/.yarn/bin ]; then export PATH=$HOME/.yarn/bin:$PATH; fi
if [ -d $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi
if [ -d $HOME/.dotfiles/bin ]; then export PATH=$HOME/.dotfiles/bin:$PATH; fi
if [ -d $HOME/.local/bin ]; then export PATH=$HOME/.local/bin:$PATH; fi
if [ -d $HOME/.local/share/umake/bin ]; then export PATH=$HOME/.local/share/umake/bin:$PATH; fi
if [ -d $HOME/.SpaceVim/bin ]; then export PATH=$HOME/.SpaceVim/bin:$PATH; fi
if [ -d $HOME/.tmuxifier/bin ]; then export PATH=$HOME/.tmuxifier/bin:$PATH; fi
if [ -d $HOME/.pyenv/shims ]; then export PATH=$HOME/.pyenv/shims:$PATH; fi

export NIX_PATH="${HOME}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
if [ -d "${HOME}/.nix-profile" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh"
    export PATH="${HOME}/.nix-profile/bin:${PATH}"
    export XDG_DATA_DIRS="${HOME}/.nix-profile/share:$XDG_DATA_DIRS"
fi

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Node/Ruby Version Manager
export PATH="$PATH:$HOME/.npm-packages/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
if [ -d "${PYENV_ROOT}/bin" ]; then
    # initialize pyenv
    eval "$(pyenv init -)"
    # initialize pyenv virtualenv
    eval "$(pyenv virtualenv-init -)"
fi
# export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.8.5/bin/python"
# export PIPX_DEFAULT_PYTHON="$(pyenv prefix $(pyenv global))/bin/python"
PIPX_DEFAULT_PYTHON="$(pyenv prefix pipx)/bin/python"
export PIPX_DEFAULT_PYTHON
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"

if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
fi

# Define terminal for i3
export TERMINAL="kitty"
