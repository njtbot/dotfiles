# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# PATH additions
export PATH=$PATH:/c/Keil_v5/ARM/ARMCC/bin:/usr/local/bin/openocd-0.7.0/bin

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

alias ls='ls --color=tty'
alias ll='ls -Flsa --color=tty'
alias df='df -h'
alias du='du -h'
alias cloud='ssh nick@cloud.nicholastrimble.com'

# get current git branch name
function git_branch {
    export gitbranch=[$(git rev-parse --abbrev-ref HEAD 2>/dev/null)]
    if [ "$?" -ne 0 ]
      then gitbranch=
    fi
    if [[ "${gitbranch}" == "[]" ]]
      then gitbranch=
    fi
}

# set TTYNAME
function ttyname() { export TTYNAME=$@; }

# Set prompt and window title
inputcolor='[0;37m'
cwdcolor='[0;34m'
gitcolor='[1;31m'
user_color='[0;32m'

# Setup for window title
export TTYNAME=$$
function settitle() {
  p=$(pwd);
  let l=${#p}-25
  if [ "$l" -gt "0" ]; then
    p=..${p:${l}}
  fi
  t="$TTYNAME $p"
  echo -ne "\e]2;$t\a\e]1;$t\a";
}

PROMPT_COMMAND='settitle; git_branch; history -a;'
export PS1='\[\e${usercolor}\]\[\e${gitcolor}\]${gitbranch}\[\e${cwdcolor}\][$PWD]\[\e${inputcolor}\] \n$ '

function gi() { curl http://www.gitignore.io/api/$@ ;}

# start a screen instance after each login

