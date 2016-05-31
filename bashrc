#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# if [ -z "$SSH_AUTH_SOCK" ] ; then
#     eval `ssh-agent` 2> /dev/null 1>&2
#     ssh-add
# fi

alias ls='ls --color=auto'
alias pa2='g++ -std=c++11 -Wall -pedantic -Wextra -g -D__VUTUNGAN__'
alias cformat='indent -bad -bap -bbb -blf -bli4 -bls -bs -ci4 -i4 -ip0 -nbbo -nbfda -ncdw -nce -nlp -npsl -pcs -saf -sai -saw'

PS1='\u@\h \w \$ '

# gnome-terminal opens current directory in new windows or tabs
. /etc/profile.d/vte.sh
