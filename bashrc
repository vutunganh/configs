# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cformat='indent -bad -bap -bbb -nbbo -nbc -bl -blf -bli0 \
-bls -cbi0 -cdb -ncdw -nce -ci2 -cli2 -ncs -nbfda -nbfde -hnl \
-i2 -ip2 -l80 -lp -nlps -npcs -pi2 -pmt -ppi0 -prs -npsl -nsaf \
-nsai -nsaw -sbi0 -sc -nsob -nss -nut'
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
