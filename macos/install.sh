# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
    echo "os must be darwin (macos)"
    exit
fi


# exit script if command fails
set -e


# set computer name
echo -n "  Set the computer's name (ie something like jays-mac): "
read computername
sudo scutil --set HostName "$computername"


# install xcode command line tools
sudo xcode-select --install || echo "XCode already installed, skipping"


## TODO: better defaults
# load defaults
bash defaults.sh


# check for brew
if test ! $(which brew); then
    echo "  Installing Homebrew for you."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# homebrew isn't added to path by default for m1 macbooks
if test -f "/opt/homebrew/bin/brew"; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# install from Brewfile
echo " Installing from Brewfile"
brew update
brew upgrade
bash brewfile.sh
brew cleanup


# iterm2
# TODO: come up with a better way to update and load iterm preferences
echo "-------- iterm2 --------

Import iterm2 settings via Preferences > General and then set the \
custom folder path to the macos folder in the dotfiles repo.


"
