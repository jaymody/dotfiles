# dotfiles

~ sweet ~

## install
```shell
git clone https://github.com/jaymody/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap
```

**Note**: If you want to use a custom install location, you'll need to export it as `DOTFILES_ROOT` in `~/.localrc` before running `./bootstrap`:
```shell
DOTFILES_ROOT="/path/to/dotfiles"
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
cd $DOTFILES_ROOT
./bootstrap
```

## docs
**`dotfiles/`:** Contains, well, dotfiles. Files in this directory get symlinked to your home directory (ie `dotfiles/bashrc` is sent to `~/.bashrc`)

**`linux/`:** Contains install scripts, settings, and configs for Linux.

**`macos/`:** Contains install scripts, settings, and configs for MacOS.

**`scripts/`:** Utility scripts (this directory is added to `PATH`).

**`<something>/setup.sh`:** Setup script for `<something>`. These scripts are run at the end of `./bootstrap`.

**`<something>/update.sh`:** Update script for `<something>`. This script is run when `./update` is called. Can be used to keep your dotfiles repo updated with latest configs files (ie copy latest vscode `settings.json`) and/or to update software (ie pull the latest version of `oh-my-zsh`).

**`link`:** Script that links files in `dotfiles/` to your home directory.

**`update`:** Script that finds and runs `<something>/update.sh` scripts.

**`bootstrap`:** All-in-one installation script.
