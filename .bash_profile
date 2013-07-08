export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home/bin/"
export PATH="$JAVA_HOME:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:$PATH"
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

eval "$(rbenv init -)"

#[[ $- == *i* ]]   &&   . ~/.git-prompt.sh

source ~/git-completion.bash
#PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '
PS1='\W$(__git_ps1 " (%s)")\$ '

export CLICOLOR=1
export HISTFILESIZE=
export HISTSIZE=
export EDITOR=vim
export JRUBY_OPTS="--1.9 -J-d32 --client -X-C"
#export JAVA_OPTS="-d32 -client"

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
  LENGTH=${1-32}
  PREV_LANG=$LANG
  LANG='C'
  cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w $LENGTH | head -n 5
  LANG=$PREV_LANG
}

exportenv() {
  while read line; do `declare -x "$line"`; done < .env
}

export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
[[ -f ~/.aws ]] && . ~/.aws

export GOPATH=$HOME/gocode
PATH=$PATH:$GOPATH/bin

