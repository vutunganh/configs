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
alias cformat='indent -bad -bap -bbb -nbbo -bc -bl -bli0 -blf -bls -bs -cbi0 -cdb -ncdw -nce -ci4 -cs -bfda -bfde -i4 -ip0 -nbfda -nce -nlp -pcs -pmt -ppi4 -prs -npsl -saf -sai -saw -nsob -nss'
alias py2=python2

PS1='\u@\h \w \$ '
