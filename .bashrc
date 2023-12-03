#================================================================
#			Alias
#================================================================
alias vim='nvim'
alias ls='ls -GF'
alias la='ls -a'
alias ll='ls -al'
alias ts='tig status'
alias relogin='exec $SHELL -l'
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs -f'
alias ke='kubectl exec'
alias dc='docker-compose'
alias lz='lazygit'
alias sed='gsed'
alias dig='dig +noedns'
alias books='cp -r ~/Library/Mobile\ Documents/iCloud~com~apple~iBooks ~/Documents/ALLMYBOOKS'
alias swagger='docker run -p 80:8080 swaggerapi/swagger-editor'
alias uconv='docker run -i --rm genzouw/uconv'
alias dev="attach_dev_contaier"
alias gcd="ghq_cd"
alias python="python3"


#================================================================
#			Git alias
#================================================================
alias gg='git grep -n'
alias gs='git status'
alias gb='git branch'
alias gp='git pull'
alias gl='git log'
alias gf='git fetch'

#================================================================
#			Key bind
#================================================================
bind -x '"\C-g": "ghq_tmux"'

#================================================================
#			Function
#================================================================

attach_dev_contaier() {
  CONTAINER_ID=$(docker ps -a | grep devenv | head -1 | cut -d ' ' -f 1)
  if [ -z $CONTAINER_ID ]; then
    docker run -it --mount type=bind,source=$HOME/,target=/workspace devenv
  else
    docker start $CONTAINER_ID && docker attach $CONTAINER_ID
  fi
}

memo() {
  mkdir -p ~/Library/Mobile\ Documents/com~apple~CloudDocs/memo
  vim --cmd 'cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/' ~/Library/Mobile\ Documents/com~apple~CloudDocs/memo/`memof $1`
}

memof() {
  echo `date +%F``echo $1 | sed 's/^\(.\)/-\1/'`.md
}

cleanup() {
  # Homebrew part
  rm -rf ~/Library/Caches/Homebrew
  brew cleanup -s 
  rm -rf $(brew --cache) 
  # remove DerivedData
  rm -rf ~/Library/Developer/Xcode/DerivedData/ 
  # remove Xcode caches
  rm -rf ~/Library/Caches/com.apple.dt.Xcode/
  killall Dock
}

reauth() { 
  gcloud auth login && gcloud auth application-default login
}

revoke() {
  echo "🚨UNSET kube context"
  kubectl config unset contexts.$(kubectl config current-context).namespace
  kubectl config unset current-context
  printf '\n'
  echo "🚨UNSET gcloud auth"
  gcloud auth revoke
}

set_ctx() {
  for c in $(get_ctx $1); do gcloud container clusters get-credentials $c --project $1 --zone $2 ; done
}

get_ctx() {
  gcloud container clusters list --project $1 | grep -v NAME | cut -d ' ' -f 1
}

rm_ctx() {
  kubectl config unset current-context
  for c in $(kubectl config get-contexts -o name); do kubectl config delete-context $c ; done
}

kn() {
  NS=$(kubectl get namespaces -o name | cut -d '/' -f 2 | fzf --height 30%)
  if [ -z $NS ]; then
    : #nothing
  else
    kubectl config set-context $(kubectl config current-context) --namespace=$NS
  fi
}

kc() {
  CONTEXT=$(kubectl config get-contexts --no-headers | awk '{print $2}' | fzf --height 30%)
  if [ -z $CONTEXT ]; then
    : #nothing
  else
    kubectl config use-context $CONTEXT
  fi
}

# show list of qhq with fzf, return full repo path after selected.
ghq_selector() {
  destination=$(ghq list | fzf --height 35%)
  if [ -z $destination ]; then
    : # nothing
  else
   echo $destination
  fi
}

ghq_tmux() {
  full_destination=$(ghq_selector)
  destination=$(echo $full_destination | rev | cut -d '/' -f 1 | rev)
  if [ -z $destination ];then
    :
  else
    session=$(tmux ls | grep $destination)
    # confirm session is already existing
    if [[ -z $session ]];then
      tmux new-session -d -s $destination -c $(echo "$(ghq root)/${full_destination}")
      attach_tmux $destination
    else
      attach_tmux $destination
    fi
  fi
}

ghq_cd() {
  cd $(echo "$(ghq root)/$(ghq_selector)")
}

# tmux shortcut
tm() {
  if [ -z $1 ]; then
    session=$(tmux ls | fzf --height 30% | cut -d ':' -f 1)
    if [ -z $session ]; then
      : #nothing
    else
      attach_tmux $session
    fi
  else
    tmux new-session -d -s $1
    attach_tmux $1
  fi
}

attach_tmux() {
    _session_name=$1
    if [[ -z $(echo $TMUX) ]];then
      tmux a -t $_session_name
    else
      tmux switch-client -t $_session_name
    fi
}

tmc() { 
  tm `current_path`
}

current_path() {
  pwd | rev | cut -d '/' -f 1 | rev
}

current_branch() {
  gb | grep '*' | cut -d ' ' -f 2
}

# format "%Y%m%d%I%M"
now(){
  date +"%Y%m%d%I%M"
}

# close download notification
cnd(){
  cliclick c:1660,1025
}

# close notifications
cn(){
  close_count=$@
  for n in `seq 1 $close_count`
  do
    cliclick c:1630,35
    sleep 0.3
  done
}

# checkout - checkout local branch
checkout() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf --height 30% +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# rcheckout - checkout remote branch
rcheckout() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf --height 30% -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# branch - delete local branch
branch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf --height 30% +m) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# gshow - git commit browser
show() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --height 100% --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#================================================================
#     General
#================================================================
[ -f $HOME/git-completion.bash ] && source $HOME/git-completion.bash
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

export FZF_DEFAULT_OPTS="--layout=reverse --bind change:top"

function share_history {
    history -a
    history -c
    history -r
}
shopt -u histappend

export HISTCONTROL=erasedups
export HISTIGNORE="ll:la:cd:gs:gb:gf:ts:tm:tmc:show:vim:kc:kn:pwd:reauth"
export HISTSIZE=7777

PROMPT_COMMAND="share_history"

if [ "" != $(which starship) ] ; then
  eval "$(starship init bash)"
fi
# for version management of Node.js 
if [ "" != $(which fnm) ] ; then
  eval "$(fnm env)"
fi
if [ -f $HOME/.carge/env ] ;then
  "HOME/.carge/env"
fi
