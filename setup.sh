#!/bin/bash

section() {
    echo "\n=== ${1} ===\n"
}

section "get Cica"
curl -OL https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
section"installed Cica"
unzip Cica_v5.0.2_with_emoji.zip
section "unzip font files"

sh ./install-fonts.sh

section "get git-completion.bash"
curl -OL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

git clean -f 
section "clean up unnecessary files"

sh ./dotfilesLink.sh
section "created symbolic link"

# $(brew --prefix)/opt/fzf/install
