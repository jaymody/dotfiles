The stuff I do setup a MacBook.

# Basics
Set the hostname:
```shell
sudo scutil --set HostName jays-mac"
```

Install XCode:
```shell
sudo xcode-select --install
```

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

# Dotfiles
See github.com/jaymody/dotfiles

# Settings
Programmatically set some preferences (things like show hidden files in finder etc ...):
```shell
bash defaults.sh
```

Then, we need to manually change some settings (some of the below are done `defaults.sh`, but some of them are not, in any case this is my comprehensive list):

**General**
- dark mode
- jump to spot that’s clicked
- none recent items

**Dock**
- scale effect
- autohide
- no show recent applications in dock
- turn off double click to X

**Mission Control**
- group windows by application
- disable automatically rearrange spaces based on most recent use

**Security and Preferences**
- require password immediately

**Sound**
- show volume in menu bar

**Keyboard**
- key repeat fast
- repeat delay shortest
- turn off autocorrect
- turn off autocapitalize
- move focus to menu bar (cmd + shift + ,)
- shortcuts spotlight to ctrl+space

**Trackpad**
- default click strength (medium)
- default tracking speed (4th tick)
- turn off force click and haptic feedback

**Display**
- automatically adjust brightness
