#!/bin/bash

section() {
    echo "\n=== ${1} ===\n"
}

section "get Cica"
curl -OL https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
section "unzip font files"
unzip Cica_v5.0.2_with_emoji.zip

sh ./install-fonts.sh

section "get git-completion.bash"
curl -OL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

section "clean up unnecessary files"
git clean -f 

section "created symbolic link"
sh ./dotfilesLink.sh

section "configure fzf to bash"
yes | $(brew --prefix)/opt/fzf/install
