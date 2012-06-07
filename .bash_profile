export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

#[[ $- == *i* ]]   &&   . ~/.git-prompt.sh

source ~/git-completion.bash
#PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '
PS1='\W$(__git_ps1 " (%s)")\$ '

export NODE_PATH=/usr/local/lib/node_modules

export EDITOR=vim
#set -o vi
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/1.7.0u.jdk/Contents/Home"
#export PATH="$JAVA_HOME/bin:$PATH"
export JRUBY_OPTS="--1.9 -J-d32 --client -X-C"
#export JAVA_OPTS="-d32 -client"
#export TORQUEBOX_HOME=~/code/torquebox/build/assembly/target/stage/torquebox
export TORQUEBOX_HOME=$HOME/torquebox-current
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export RBXOPT="-X19"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

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
  LENGTH=${1-64}
  PREV_LANG=$LANG
  LANG='C'
  cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w $LENGTH | head -n 5
  LANG=$PREV_LANG
}
