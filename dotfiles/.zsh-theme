# Most terminals support the colours
# black, red, green, yellow, blue, magenta, cyan, white
# Print terminal colours:
# for C in {0..255}; do tput setab $C; echo -n "$C "; done; tput sgr0; echo

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}\uE0A0"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"

local c_grey="237"

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
show_rvm_prompt() {
    rvm current &>/dev/null
}

# Build prompt in correct order. Broken down for easy reading.
# local -a prompt_array=(
prompt_array=(
time            "⌚ %D{%T} "
user            "%{$fg[yellow]%}%n"
hostname        "$(show_host_prompt && echo "@%{$fg[green]%}%m%{$reset_color%}")"
current_dir     ":%{$fg_bold[cyan]%}%2c "
git_prompt      '$(git_super_status) '
new_line        $'\n'
return_status   "%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})➜  "
final           "%"
)
# Build prompt in correct order. Broken down for easy reading.
local -a rprompt_array=(
nvm    "%{$FG[$c_grey]%}$(show_nvm_prompt && echo 'node-$(nvm_ls current) ')"
rvm    "%{$FG[$c_grey]%}$(show_rvm_prompt && echo '$($HOME/.rvm/bin/rvm-prompt)')"
final  "%"
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
