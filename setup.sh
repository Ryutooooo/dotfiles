/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "brew installed"

brew bundle install --file=.brewfile
echo "installed your libraries and apps"

./dotfilesLink.sh
