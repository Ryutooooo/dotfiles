export LANG=ja_JP.UTF-8
export EDITOR=vim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

eval "$(anyenv init -)"

export GOPRIVATE=github.com/zeals-co-ltd/protobuf
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryutooooo/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ryutooooo/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryutooooo/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ryutooooo/google-cloud-sdk/completion.bash.inc'; fi

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi
