# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
    echo "os must be darwin (macos)"
    exit
fi

# fetch dotfiles root
[ $# -eq 0 ] && fail "1 argument required [path to dotfiles repo root directory]"
[ ! -d "$1" ] && fail "directory ($1) was not found."
DOTFILES_ROOT=$1


# exit script if command fails
set -e


# set computer name
echo -n "  Set the computer's name (ie something like jays-mac): "
read computername
sudo scutil --set HostName "$computername"


# install xcode command line tools
xcode-select --install || echo "XCode already installed, skipping"


## TODO: better defaults
# load defaults
bash ${DOTFILES_ROOT}/macos/defaults.sh


# check for brew
if test ! $(which brew); then
    echo "  Installing Homebrew for you."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# install from Brewfile
echo " Installing from Brewfile"
brew update
brew upgrade
bash ${DOTFILES_ROOT}/macos/brewfile.sh
brew cleanup


# iterm2
# TODO: come up with a better way to update and load iterm preferences
echo "-------- iterm2 --------

Import iterm2 settings via Preferences > General and then set the \
custom folder path to the macos folder in the dotfiles repo.


"
