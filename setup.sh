#!/bin/bash

./dotfilesLink.sh
echo "created symbolic link"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "brew installed"
