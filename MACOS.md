Bootstrapping a new MacBook.

# Settings
First, let's set some sane defaults for programmers (might require a restart for these changes to take affect):
```shell
# Allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
```

Then, manually change the following settings:

**Appearance**
- Dark mode
- Jump to spot that’s clicked

**Desktop & Dock**
- Scale effect
- Autohide dock
- Disable show recent applications in dock
- Turn off double click to X

**Mission Control**
- Group windows by application
- Disable automatically rearrange spaces based on most recent use

**Lock Screen**
- Require password immediately

**Keyboard**
- Key repeat fast
- Repeat delay shortest
- Turn off autocorrect
- Turn off autocapitalize
- Turn off add period with double space
- Shortcuts spotlight to ctrl+space or disable it

**Trackpad**
- Default click strength (medium)
- Default tracking speed (4th tick)
- Turn off force click and haptic feedback


# Basics
Set the hostname:
```shell
sudo scutil --set HostName "jays-mac"
```

Install XCode (which installs `git` and other important CLI tools):
```shell
sudo xcode-select --install
```

# Github
Let's setup access to github so we can clone repos over ssh.

First, we generate an ssh key (passphrase is optional):
```shell
ssh-keygen -t rsa -b 4096
```

Then, we copy the output of:
```shell
cat ~/.ssh/id_rsa.pub
```

And [add it as new ssh key to our github](https://github.com/settings/ssh/new).

# Dotfiles
See github.com/jaymody/dotfiles

# Apps

Install [homebrew](https://brew.sh):
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Update and upgrade homebrew:
```shell
brew update
brew upgrade
```

Install basic CLI tools I use a lot:
```shell
brew install \
    coreutils \
    direnv \
    fd \
    fx \
    htop \
    tree \
    tmux \
    watch \
    wget
```

Install my essential apps:
```shell
brew install --cask \
    bitwarden \
    brooklyn \
    discord \
    docker \
    gimp \
    google-chrome \
    google-drive \
    iterm2 \
    keyboard-cleaner \
    mactex-no-gui \
    messenger \
    microsoft-teams \
    notion \
    obsidian \
    raycast \
    rectangle \
    slack \
    spotify \
    visual-studio-code \
    whatsapp \
    zoom
```

Cleaup:
```shell
brew cleanup
```
