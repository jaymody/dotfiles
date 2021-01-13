# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
  	echo "os must be darwin (macos)"
    exit
fi


# exit script if command fails
set -e


## TODO: get input to set host name
# set computer name
sudo scutil --set HostName jays-mbp


# install xcode command line tools
xcode-select --install


## TODO: better defaults
# load defaults
bash ${DOTFILES_ROOT}/macos/defaults.sh


# check for brew
if test ! $(which brew); then
    echo "  Installing Homebrew for you."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# install from Brewfile
echo " Installing from Brewfile"
brew update
brew upgrade
brew bundle --file ${DOTFILES_ROOT}/macos/Brewfile
brew cleanup


# iterm2
echo "NOTE: unfortunately, there is no way to import iterm2 settings via \
command-line. To import manually, open Preferences > General and set the \
custom folder path to the macos folder in the dotfiles repo."


# better touch tool
echo "NOTE: unfortunately, there is no way to import bettertouchtools settings \
via command line, you'll have to import the preset manually"
