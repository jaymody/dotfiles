The stuff I do setup a MacBook.

# Basics
Set the hostname:
```shell
sudo scutil --set HostName "jays-mac"
```

Install XCode (which installs `git` and other important CLI tools):
```shell
sudo xcode-select --install
```

# Git
With that, we want to setup access to github so we can clone repos over ssh.

First, we generate an ssh key (passphrase is optional):
```shell
ssh-keygen -t rsa -b 4096
```

Then, we copy the output of:
```shell
cat ~/.ssh/id_rsa.pub
```

And [add a new ssh key to our github](https://github.com/settings/ssh/new) using the copied public key.

We should now be able to clone repos over ssh. To test it, try:

```shell
git clone git@github.com:jaymody/dotfiles.git ~/.dotfiles
```

# Dotfiles
See github.com/jaymody/dotfiles/README.md

# Homebrew and Apps
Install homebrew:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install homebrew formulas:
```shell
brew update
brew upgrade
bash brewfile.sh
brew cleanup
```

# Settings
Programmatically set some preferences (things like show hidden files in finder etc ...):
```shell
bash defaults.sh
```

Then, we need to manually change some settings (some of the below are done `defaults.sh`, but some of them are not, in any case this is my comprehensive list):

**Appearance**
- dark mode
- jump to spot that’s clicked

**Desktop & Dock**
- scale effect
- autohide dock
- disable show recent applications in dock
- turn off double click to X

**Mission Control**
- group windows by application
- disable automatically rearrange spaces based on most recent use

**Lock Screen**
- require password immediately

**Keyboard**
- key repeat fast
- repeat delay shortest
- turn off autocorrect
- turn off autocapitalize
- turn off add period with double space
- shortcuts spotlight to ctrl+space or disable it

**Trackpad**
- default click strength (medium)
- default tracking speed (4th tick)
- turn off force click and haptic feedback
