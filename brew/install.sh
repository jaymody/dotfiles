#!/bin/sh

# check for brew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  else
  	echo "os must be linux or darwin"
    exit 1
  fi
fi

# install from Brewfile
echo " Installing from Brewfile"
brew update
brew upgrade
brew bundle --file ./Brewfile
brew cleanup

exit 0
