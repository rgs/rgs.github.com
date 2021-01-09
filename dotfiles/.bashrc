# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# bash internal variables

CDPATH=.:~
HISTCONTROL=ignoreboth
HISTIGNORE=bg:fg:cd:lsc:ll:l:h:w:exit
FIGNORE=.o
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s lithist

# environment

export LESS=FRSXi
export LESSCHARSET=utf-8
export EDITOR=/usr/bin/vim
export MYSQL_PS1="\\d@\\h> "
export MYSQLY_OPTS=-x

# Some useful aliases

alias dfh='df -h'
alias duh='du -h'
alias h=history
alias ll='ls -lA'
alias lsf='ls -F'
case $OSTYPE in
  linux*)
    alias lsc='ls --color=tty'
    alias llc='ls -lA --color'
    alias l='ls -lh --color=tty'
    PS1="\033]0;$ROLE_FOR_PROMPT\007\[\033[1m\][\u@\h ($ROLE_FOR_PROMPT) \W]\$\[\033[0m\] "
    unset PROMPT_COMMAND
  ;;
  darwin*)
    alias lsc='ls -G'
    alias llc='ls -lAG'
    alias l='ls -lhG'
    PS1="\033]0;Terminal\007\[\033[1m\]\W\$\[\033[0m\] "
  ;;
esac
alias gti=git
alias wvim='tmux neww vim'
alias hvim='tmux splitw -h vim'
alias vvim='tmux splitw -v vim'

# bash functions

hl() {
    perl -MTerm::ANSIColor=:constants \
	-lpe 'BEGIN{$r=shift}s/($r)/BOLD.YELLOW.$1.RESET/eog' $*
}
ressh() {
    if [ -n "$TMUX" ]; then
        eval $(tmux showenv -s SSH_AUTH_SOCK)
    else
        echo 'No tmux!'
    fi
}

# non-generic settings and machine-local aliases

if [ -f ~/.alias ]; then
	. ~/.alias
fi

# disable git and tmux bash completion
complete -o bashdefault -o default -o nospace git
complete -o bashdefault -o default -o nospace tmux
