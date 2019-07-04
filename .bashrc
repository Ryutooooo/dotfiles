export PS1="[\[\e[1;37m\]\[\e[m\]\w]$ "

export FZF_DEFAULT_OPTS='--reverse --border'

source $HOME/.git-completion.bash

alias cat='cat -n'
alias ls='ls -GF'
alias la='ls -a'
alias ts='tig status'
alias relogin='exec $SHELL -l'


#================================================================
#			Git alias
#================================================================
alias grep='grep --color=auto'
alias gg='git grep'
alias gs='git status'
alias gb='git branch'
alias gp='git pull'
alias gl='git log'



#================================================================
#			Function
#================================================================
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

# the result by git grep pass to vim
vgrep(){
  name_number=$(git grep $@ | fzf | cut -d ":" -f 1,2)
  if [ -n "$name_number" ]; then
    name=$(echo $name_number | cut -d ":" -f 1)
    number=$(echo $name_number | cut -d ":" -f 2)
    vim -c $number $name
  else
    echo 'fileが見つかりません'
  fi
}

# checkout - checkout local branch
checkout() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# rcheckout - checkout remote branch
rcheckout() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# branch - delete local branch
branch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# gshow - git commit browser
show() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
