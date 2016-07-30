source ~/.bashrc

#  _               _                        __ _ _
# | |__   __ _ ___| |__    _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \  | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | | | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_| | .__/|_|  \___/|_| |_|_|\___|
#                         |_|
#
alias ls='ls -F'
alias la='ls -la'
alias rm="rm -i"
alias b='cd ../'
alias reload="clear; source ~/.bash_profile"

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # http://geoff.greer.fm/lscolors/

## Tab improvements
bind 'set completion-ignore-case on'
bind 'TAB: menu-complete'

export LC_ALL="en_US.UTF-8"
export LANG="en_US"

alias h='history'
# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
# ignore same successive entries.
export HISTCONTROL=ignoreboth
# Make some commands not show up in history
export HISTIGNORE="h:ls:ll:ll *:"

# Set the TERM var to xterm-256color
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi
if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # this is for xterm-256color
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 226)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    ORANGE=$(tput setaf 172)
    PURPLE=$(tput setaf 141)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  R=$(tput sgr0)
  UL=$(tput sgr 0 1)
else
  BLACK="\[\e[0;30m\]"
  RED="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  YELLOW="\[\e[0;33m\]"
  CYAN="\[\e[0;36m\]"
  BLUE="\[\e[0;34m\]"
  BOLD=""
  R="\033[m"
fi

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# Hide/show hidden files in Finder
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias showfiles="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# List any open internet sockets on port 3000.
# Useful if a rogue server is running
# http://www.akadia.com/services/lsof_intro.html
alias rogue='lsof -i TCP:3000'

alias fuck_deps='npm prune && npm install && npm update && bower prune && bower install && bower update'

# APPLICATION SETTINGS
##########################################################################
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Make sublime our editor of choice
export EDITOR="subl -w"

export NVM_DIR="/Users/thomasweaver/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

function test_it() {
  repo=${PWD##*/}

  if [ "$repo" = "advisor-service" ]; then
    python_bin='venv/bin/python'
    manage='advisor_project/manage.py'
    service='advisor_service'
  elif [ "$repo" = "pinterest-service" ]; then
    python_bin='env/bin/python'
    manage='test_project/manage.py'
    service='pinterest_service'
  else
    echo "${RED}not implemented${R}"
    return
  fi

  settings="$service.test_settings"
  tests="$service.tests"
  specific_tests_to_run=$1 
  if [ $specific_tests_to_run ]; then
    tests+=".$specific_tests_to_run"
  fi

  eval "$python_bin $manage test $tests --settings=$settings"
}

function cm() {
  echo 'adding...'
  eval 'git add .'

  branch=$(__git_ps1 "%s")
  jira_ticket="${branch#*/}"
  message=$jira_ticket

  if [ $# -ne 0 ]; then
    message="$message $@"
  fi

  echo "commit message: $message"
  read -s -n 1 key
  if [ "$key" = '' ]; then
    echo 'committing...'
    eval "git commit -m '$message'"
  else
    echo 'aborting...'
    return
  fi
}

PS1='${BOLD}[${R} ${UL}\d${R}:'
PS1+=' ${BOLD}${BLUE}\W${R}'
PS1+='$(__git_ps1 " ${GREEN}*%s*${R}") ${BOLD}]${R} '
