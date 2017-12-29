# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='ls:bg:fg:cd'

alias ls='ls --color=auto'
alias cformat='indent -bad -bap -bbb -nbbo -nbc -bl -blf -bli0 \
-bls -cbi0 -cdb -ncdw -nce -ci2 -cli2 -ncs -nbfda -nbfde -hnl \
-i2 -ip2 -l80 -lp -nlps -npcs -pi2 -pmt -ppi0 -prs -npsl -nsaf \
-nsai -nsaw -sbi0 -sc -nsob -nss -nut'
alias py2='python2'
alias py='python'
alias ..='cd ..'
function mkcd {
  mkdir "$1" && cd "$1"
}
source /usr/share/git/completion/git-prompt.sh

export TERM=xterm-256color

PS1='\u@\h \w $(__git_ps1 "(%s)")\n\$ '
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1

if [ $( type -P 'nvim' ) ]; then
  alias vim='nvim'
fi

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent -s` > /dev/null 2>&1
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null 2>&1 || ssh-add > /dev/null 2>&1

for f in ~/.ssh/*; do
  if [[ "$f" != *.pub && "$f" != 'known_hosts' ]]; then
    ssh-add "$f" > /dev/null 2>&1
  fi
done
