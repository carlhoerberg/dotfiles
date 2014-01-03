if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export PATH="~/bin:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:$PATH"
#export JAVA_HOME="$(/usr/libexec/java_home)"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export GOPATH=$HOME/gocode
PATH=$PATH:$GOPATH/bin

[[ -f ~/.credentials ]] && . ~/.credentials

function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

export PROMPT_COMMAND='printf "\e]1;${HOSTNAME##*.local} ${PWD##*/}\a"'
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

