export LANG=ja_JP.UTF-8
export EDITOR=nvim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="~/flutter/bin:$PATH"

export CLOUDSDK_PYTHON=python

eval "$(anyenv init -)"
eval "$(nodenv init -)"

export GOPATH=$HOME/.go
export GOPRIVATE=github.com/zeals-co-ltd/protobuf

export PATH="$GOPATH/bin:$PATH"

export PATH=$PATH:~/.kube/plugins/jordanwilson230

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryutooooo/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ryutooooo/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryutooooo/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ryutooooo/google-cloud-sdk/completion.bash.inc'; fi

# for nand2tetris
export PATH="$PATH:`ghq root`/`ghq list | grep nand`/tools"

export PATH="$PATH:/Users/ryutooooo/Library/Android/sdk/platform-tools"

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi
