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

complete -C aws_completer aws

[ -x /usr/libexec/java_home ] && export JAVA_HOME=`/usr/libexec/java_home 2> /dev/null`

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -f ~/.credentials ]] && . ~/.credentials
PS1='\W$(__git_ps1 " (%s)")\$ '

export CLICOLOR=1
export HISTFILESIZE=
export HISTSIZE=
export EDITOR=vim

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

ssh() {
  [ -n "$TMUX" ] && tmux rename-window "${@: -1}"
  $(which ssh) $*
}

function use-osx-ssh-agent() {
  if [ ! -f "/tmp/.ssh-agent-info" ]
  then ssh-agent > /tmp/.ssh-agent-info
  fi
  . /tmp/.ssh-agent-info
  [ -S "$SSH_AUTH_SOCK" ] || ( rm /tmp/.ssh-agent-info && use-osx-ssh-agent )
}
use-osx-ssh-agent

epsql() {
  psql $(heroku config:get ELEPHANTSQL_URL -a ${1:-$(basename $PWD)})
}
dpsql() {
  psql $(heroku config:get DATABASE_URL -a ${1:-$(basename $PWD)})
}

ppl() {
  git push origin && git push heroku && heroku logs -t
}

ptl() {
  open https://papertrailapp.com/systems/$(basename $PWD)/events
}

PROMPT_COMMAND='[ -n "$TMUX" ] && tmux rename-window $(basename $(pwd))'

export LLVM_CONFIG=/usr/local/Cellar/llvm@6/6.0.1_1/bin/llvm-config
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:~/code/tools/bin"

[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux
[[ -z "$TMUX" ]] && ([ `tmux list-sessions | wc -l` -eq 0 ] && exec tmux || exec tmux a -d)

