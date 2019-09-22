if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

export LANG=ja_JP.UTF-8
export EDITOR=vim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
