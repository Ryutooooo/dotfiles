if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

export LANG=ja_JP.UTF-8
export EDITOR=vim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export BASH_SILENCE_DEPRECATION_WARNING=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/$(whoami)/google-cloud-sdk/path.bash.inc' ]; then . '/Users/$(whoami)/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/$(whoami)/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/$(whoami)/google-cloud-sdk/completion.bash.inc'; fi

if [ -d ${HOME}/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
	for D in `ls $HOME/.anyenv/envs`
	do
		export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
	done

fi

export PATH="/usr/local/sbin:$PATH"
