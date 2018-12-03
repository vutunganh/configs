# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ $TERM == xterm-termite ]]; then
      .  /etc/profile.d/vte.sh
      __vte_prompt_command
fi

shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='ls:bg:fg:cd'

alias ls='ls --color=auto'
alias py2='python2'
alias py='python'
alias ..='cd ..'
alias cal='cal -m'

function mkcd {
  mkdir "$1" && cd "$1"
}

if [ -z "${GIT_PROMPT_PATH}" ]; then
	echo "Export git prompt path in ~/.bashrc"
else
	source "${GIT_PROMPT_PATH}"
fi

export TERM=xterm-256color

PS1='\u@\h \w $(__git_ps1 "(%s)")\n\$ '
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1

export EDITOR=vim

# if [ $( type -P 'nvim' ) ]; then
#   alias vim='nvim'
# fi

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent -s` > /dev/null 2>&1
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null 2>&1 || ssh-add > /dev/null 2>&1

for f in ~/.ssh/*; do
  if [[ "$f" != *.pub && "$f" != 'known_hosts' && "$f" != 'config' ]]; then
    ssh-add "$f" > /dev/null 2>&1
  fi
done
