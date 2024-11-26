# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd
shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='ls:bg:fg:cd:vim:nvim'

alias ls='ls --color=auto'
alias cal='cal -m'
alias cp='cp -i'
alias mv='mv -i'

function mkcd {
  mkdir "$1" && cd "$1"
}

if [ -z "${GIT_PROMPT_PATH}" ]; then
  echo "Export git prompt path in ~/.bashrc"
  PS1='[\t] [\u@\h \w]\n\$ '
else
  source "${GIT_PROMPT_PATH}"
  PS1='[\t] [\u@\h \w] $(__git_ps1 "(%s)")\n\$ '
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWUPSTREAM=1
fi

# Emit OSC 7 escape sequence so foot terminal can open new windows and retain cwd.
# Reference: https://codeberg.org/dnkl/foot/wiki/Home#how-to-configure-my-shell-to-emit-the-osc-7-escape-sequence
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd
