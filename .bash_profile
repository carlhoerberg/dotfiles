export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

[ -x /usr/libexec/java_home ] && export JAVA_HOME=`/usr/libexec/java_home`

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="~/code/84codes/tools/bin:~/bin:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:$PATH"
#export JAVA_HOME="$(/usr/libexec/java_home)"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -f ~/.credentials ]] && . ~/.credentials

function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

export PROMPT_COMMAND='printf "\e]1;${HOSTNAME##*.local} ${PWD##*/}\a"; update_terminal_cwd'
PS1='\W$(__git_ps1 " (%s)")\$ '

export CLICOLOR=1
export HISTFILESIZE=
export HISTSIZE=
export EDITOR=vim
export JRUBY_OPTS="-X-C"
#export JAVA_OPTS="-d32 -client"

function rmb {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
    echo "Fetching merged branches..."
  git remote prune origin
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}

function mkpasswd {
  LENGTH=${1-32}
  PREV_LANG=$LANG
  LANG='C'
  cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w $LENGTH | head -n 5
  LANG=$PREV_LANG
}

pgurl2env () {
  local URL=$1
  local PGUSER=`echo $URL | sed -e 's/.*\/\([^:]*\):.*/\1/'`
  local PGPASSWORD=`echo $URL | sed -e 's/.*:\([^@]*\)@.*/\1/'`
  local PGHOST=`echo $URL | sed -e 's/.*@\([^:\/]*\)[:/].*/\1/'`
  local PGPORT=`echo $URL | sed -e 's/.*:\([0-9]*\)\/.*$/\1/'`
  local PGDATABASE=`echo $URL | sed -e 's/.*\/\(.*\)$/\1/'`
  env PGUSER=$PGUSER PGPASSWORD=$PGPASSWORD PGHOST=$PGHOST PGPORT=$PGPORT PGDATABASE=$PGDATABASE $2
}

function ssht(){
  ssh $* -t 'tmux a || tmux || /bin/bash'
}

export PGSSLMODE=require

function use-gpg-agent() {
  GPG_TTY=$(tty)
  export GPG_TTY
  if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
  fi
}
use-gpg-agent

export MONO_GAC_PREFIX="/usr/local"

epsql() {
  psql $(hk env -a $1 | grep ELEPHANTSQL_URL | awk -F= '{print $2}')
}
dpsql() {
  psql $(hk env -a $1 | grep DATABASE_URL | awk -F= '{print $2}')
}

PROMPT_COMMAND='[ -n "$TMUX" ] && tmux rename-window $(basename $(pwd))'

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
