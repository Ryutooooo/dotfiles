#!/bin/bash

sh ./dotfilesLink.sh
echo "created symbolic link"

curl -OL https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
echo "installed Cica"
unzip Cica_v5.0.2_with_emoji.zip
echo "unzip font files"

sh ./install-fonts.sh

git clean -f 
echo "clean up unnecessary files"

# $(brew --prefix)/opt/fzf/install
