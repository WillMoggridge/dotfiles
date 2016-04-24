# Most terminals support the colours
# black, red, green, yellow, blue, magenta, cyan, white
# Print terminal colours:
# for C in {0..255}; do tput setab $C; echo -n "$C "; done; tput sgr0; echo

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}[%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[yellow]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗" # For basic git prompt
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[yellow]%}\uE0A0"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"

local c_grey="237"
local cmd_pyenv_version='pyenv version | sed -e "s/ (set.*$//" | tr "\n" " " | sed "s/.$//"'
local exit_code=$?

show_host_prompt() {
    local host_type=$(hostname | cut -d- -f2)
    if [ $host_type = "desktop" ] || [ $host_type = "laptop" ]; then
        return 1
    fi
    return 0
}
show_nvm_prompt() {
    nvm current &>/dev/null
}
show_pyenv_prompt() {
    pyenv version &>/dev/null
}
show_rvm_prompt() {
    rvm current &>/dev/null
}
show_user_prompt() {
    [ $(whoami) = 'will' ] && return 1
    return 0
}

# Build prompt in correct order. Broken down for easy reading.
# local -a prompt_array=(
local -a prompt_array=(
bg_jobs         "%(1j.%{$fg[red]%} .)"
time            "⌚ %D{%T} "
user            "$(show_user_prompt && echo "%{$fg_bold[red]%}%n ")"
hostname        "$(show_host_prompt && echo "@%{$fg[green]%}%m%{$reset_color%} ")"
current_dir     "%{$fg[cyan]%}%2c "
git_prompt      '$(git_super_status)'
# new_line        $'\n'
root_user       "%(!:%{$fg_bold[yellow]%}⚡ :)"
return_status   "%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})➜  "
final           "%"
)
# Build prompt in correct order. Broken down for easy reading.
local -a rprompt_array=(
nvm    "%{$FG[$c_grey]%}$(show_nvm_prompt && echo ' node-$(nvm_ls current)')"
python "%{$FG[$c_grey]%}$(show_pyenv_prompt && echo ' python-$('"${cmd_pyenv_version}"')')"
rvm    "%{$FG[$c_grey]%}$(show_rvm_prompt && echo ' $($HOME/.rvm/bin/rvm-prompt)')"
return_code     "%(?:: %{$fg_bold[red]%}%?⏎)"
final           "%"
)


# Concat prompt. Ignore odd indexes, they are just convenient labels.
PROMPT=''
for ((i=0; i < ${#prompt_array[@]}; i++)); do
    if (( $(($i % 2 )) == 0 )); then
        PROMPT="${PROMPT}${prompt_array[i]}%{$reset_color%}"
    fi
done
RPROMPT=''
for ((i=0; i < ${#rprompt_array[@]}; i++)); do
    if (( $(($i % 2 )) == 0 )); then
        RPROMPT="${RPROMPT}${rprompt_array[i]}%{$reset_color%}"
    fi
done
