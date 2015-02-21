ZSH=$HOME/.oh-my-zsh
ZSH_THEME="../../"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Add bin paths
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/.tmuxifier/bin:$PATH

# Source files
if [ -f $ZSH/oh-my-zsh.sh ]; then source $ZSH/oh-my-zsh.sh; fi
if [ -f $HOME/.aliases ]; then source $HOME/.aliases; fi
if [ -f $HOME/.local_envs ]; then source $HOME/.local_envs; fi

# Add Gnome Keyring as the SSH auth if we are in i3
if [ $DESKTOP_SESSION = "i3" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK GPG_AGENT_INFO GNOME_KEYRING_CONTROL GNOME_KEYRING_PID
    export SSH_AGENT_PID=$GNOME_KEYRING_PID
fi

# Stop zsh making it rename folder into variables!
unsetopt auto_name_dirs

function src() { cd ~/Source/$1; }
_src() { _files -W ~/Source; }
compdef _src src 

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt appendhistory autocd beep extendedglob notify
bindkey -e

##### Example leftovers

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR="vim"
export VISUAL="vim"

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
