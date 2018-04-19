# NOT executed by login bash instances (e.g. the ones created by terminal)
# Run each time a shell is created within tmux

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Disable per-session shell command history
export SHELL_SESSION_HISTORY=0

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PS1='\[\033[0;33m\]\u@\h:\[\033[00m\]\w\[\033[0;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

alias ls='ls -F'
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias mvim='vim -g'
  export VISUAL='vim -f'
  export EDITOR='vim -f'
fi
alias vi='vim'

alias gl="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
alias gp="git push"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"

export NVM_DIR="$HOME/.nvm"
nvmload() {
  unset -f nvm
  unset -f node
  unset -f npm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  unset -f nvmload
}

# Lazy load nvm first time for tmux shells
# $PATH with npm etc. will be setup by containing shell
node() {
  nvmload
  node "$@"
}
npm() {
  nvmload
  npm "$@"
}
nvm() {
  nvmload
  nvm "$@"
}

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true


export NODE_ENV='development'

