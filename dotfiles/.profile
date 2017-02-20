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

GOPATH="$HOME/.local/share/go"

# Add extra paths
export PATH=$GOPATH/bin:$PATH
if [ -d $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi
if [ -d $HOME/.dotfiles/bin ]; then export PATH=$HOME/.dotfiles/bin:$PATH; fi
if [ -d $HOME/.local/bin ]; then export PATH=$HOME/.local/bin:$PATH; fi
if [ -d $HOME/.local/share/umake/bin ]; then export PATH=$HOME/.local/share/umake/bin:$PATH; fi
if [ -d $HOME/.tmuxifier/bin ]; then export PATH=$HOME/.tmuxifier/bin:$PATH; fi


# Node/Ruby Version Manager
export PATH="$PATH:$HOME/.npm-packages/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"

if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.canonistack/novarc ]; then source $HOME/.canonistack/novarc; fi
if [ -f $HOME/.torch/install/bin/torch-activate ]; \
    then source $HOME/.torch/install/bin/torch-activate; fi

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"; fi

export PATH="$HOME/.cargo/bin:$PATH"
