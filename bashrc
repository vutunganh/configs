# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cformat='indent -bad -bap -bbb -nbbo -bc -bl -bli0 \
-blf -bls -bs -cbi0 -cdb -ncdw -nce -ci4 -cs -bfda -bfde \
-i4 -ip0 -nbfda -nce -nlp -pcs -pmt -ppi4 -prs -npsl -saf \
-sai -saw -nsob -nss'
alias py2='python2'
alias py='python'

export TERM=xterm-256color

PS1='\u@\h \w \$ '

function pa2 ( )
{
  FILENAME="$1"
  shift
  g++ -std=c++11 -Wall -pedantic -Wextra -g -D__VUTUNGAN__ "${FILENAME}" -o "${FILENAME%.cpp}.out" "$@"
}

function cc ( )
{
  FILENAME="$1"
  shift
  gcc -std=c99 -Wall -pedantic -Wextra -g -D__VUTUNGAN__ "${FILENAME}" -o "${FILENAME%.c}.out" "$@"
}

alias vim='nvim'
