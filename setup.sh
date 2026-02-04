#!/bin/bash

section() {
    echo "\n=== ${1} ===\n"
}

# TODO: need to execute brew

# TODO: add validation to GITHUB_TOKEN is set or not

envsubst < .gitconfig.txt > .gitconfig

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

section "install Claude Code"
if command -v claude >/dev/null 2>&1; then
    echo "Claude Code is already installed: $(claude --version)"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi
