if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

export LANG=ja_JP.UTF-8
export EDITOR=vim

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
