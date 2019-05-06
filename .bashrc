source ~/.git-completion.bash

export PS1="[\[\e[1;37m\]\[\e[m\]\w]$ "

export FZF_DEFAULT_OPTS='--reverse --border'

alias rm='rm -i'
alias cat='cat -n'
alias ls='ls -GF'
alias la='ls -a'
alias ts='tig status'


#================================================================
#			Git alias
#================================================================
alias grep='grep --color=auto'
alias gg='git grep'
alias gs='git status'
alias gb='git branch'
alias gp='git pull'


#================================================================
#			Function
#================================================================

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

# gcheckout - checkout local branch
gcheckout() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# grcheckout - checkout remote branch
grcheckout() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gbranch - delete local branch
gbranch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# gshow - git commit browser
gshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
