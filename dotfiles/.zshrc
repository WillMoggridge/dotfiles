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
plugins=(
    adb
    autojump
    catimg
    colorize
    command-not-found
    cp
    dircycle
    django
    docker
    gem
    git
    git-prompt
    github
    gulp
    heroku
    httpie
    mosh
    node
    npm
    nvm
    pip
    rvm
    systemd
    taskwarrior
    tmux
    tmuxinator
    urltools
    vagrant
    virtualenvwrapper
)

source <(antibody init)
antibody bundle <<EOBUNDLE
  jimhester/per-directory-history
  larkery/zsh-histdb
  superbrothers/zsh-kubectl-prompt
  supercrabtree/k
  unixorn/docker-helpers.zshplugin
  webyneter/docker-aliases
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
EOBUNDLE
#Arlon1/Snappy_zsh_autocompletion

# Ignore commands that start with a space
setopt HIST_IGNORE_SPACE

# Stop zsh making it rename folder into variables!
unsetopt auto_name_dirs

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt histignorespace
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt nomatch
unsetopt auto_cd beep extendedglob notify
bindkey -e

# Bullet-train theme settings
BULLETTRAIN_PROMPT_ORDER=(
    time
    custom
    context
    dir
    virtualenv
    ruby
    nvm
    go
    git
    hg
    cmd_exec_time
)
BULLETTRAIN_PROMPT_CHAR='➜'
BULLETTRAIN_CONTEXT_DEFAULT_USER='will'

# zsh-histdb permission errer: https://github.com/larkery/zsh-histdb/pull/31
HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')

# Set autosuggest strategy
_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
#ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^ ' autosuggest-accept

# Oh my ZSH
if [ -f $ZSH/oh-my-zsh.sh ]; then source $ZSH/oh-my-zsh.sh; fi

local ZSH_SYNTAX_HL=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -f $ZSH_SYNTAX_HL ]; then
    . $ZSH_SYNTAX_HL
    # 8 = bright black
    ZSH_HIGHLIGHT_STYLES[comment]='fg=214'
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(
        main
        brackets
        cursor
        pattern
        #regexp
    )
    # User patterns
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
    #ZSH_HIGHLIGHT_REGEXP+=('\bsudo\b' fg=123,bold)
fi

if cmd_exists kubeadm; then . <(kubeadm completion zsh); fi
if cmd_exists kubectl; then . <(kubectl completion zsh); fi
if cmd_exists minikube; then . <(minikube completion zsh); fi
if cmd_exists pipenv; then . <(pipenv --completion); fi

# MOTD for the terminal
login-motd
