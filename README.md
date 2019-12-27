# dotfiles

A git repo for all my dotfiles.

Heavily inspired by https://github.com/holman/dotfiles.git, it's a great repo, go check it out.


## install
```sh
DOTFILES_ROOT="~/.dotfiles"
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ~/.localrc
source ~/.localrc

curl -LO https://github.com/jaymody/dotfiles/archive/master.zip
unzip master.zip
rm master.zip
mv dotfiles-master $DOTFILES_ROOT
```
This will download the repo to `~/.dotfiles`, however you can change `$DOTFILES_ROOT` to save it wherever you want. It's important that `$DOTFILES_ROOT` is an accesible environment variable as many of the scripts in the repo depend on it, which is why `export DOTFILES_ROOT=path/to/dotfiles/dir` is being appended to .localrc (which then is to be sourced by `.zshrc` or `.bashrc`)

## usage

The are 2 main functionalities for this repository:
1. Track and organize all my dotfiles, scripts, aliases, shell inits, etc ...
2. Store my system, dev, and app settings so that I can restore them easily on if I were to reset my machine.

Everything is organized by topic, so you don't have to go scrambling around to find where you put the alias for `json`, or where in your `.zshrc` anaconda is being initialized, or scratch your head trying to remember what commands you inputed to install `docker`.

This is done using a couple of special files/folders in the repo:

- **bin/**: This folder is added to your `$PATH` in `.zshrc` so any scripts you put in it are easily reachable via your shell.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your environment via `source *.zsh`.
- **topic/init.zsh**: Any file named `init.zsh` is loaded first (might be needed to set up a `$PATH` or similar for other .zsh files in same the topic directory).
- **topic/install.sh**: Any file named `install.sh` is executed when you run `install`. These need to manually added to the install script since order matters (technically you can name `topic/install.sh` anything as long as the right reference is made in `./install`)
- **topic/save.sh**: Any file named `save.sh` is executed when you run `save`. These are meant to be scripts that will save settings from your current setup that aren't symlinked files in your homedir (things like settings.json from vscode, Brewfile, .plists, etc ...)
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into your `$HOME`. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run `./dotfiles`.

### `./dotfiles`
Updates the symlinks in the repo to the ones in your home dir (which are denotes by `topic/*.symblink`):
```sh
cd $DOTFILES_ROOT
./dotfiles
```

### `./install`
On a fresh install of a system run the following to install homebrew, setup your system preferences, apps via install scripts specified in the file (often `topic/install.sh`):
```sh
cd $DOTFILES_ROOT
./install
```

### `./save`
Saves various settings on your machine that can't be symlinked from this repo:
```sh
cd $DOTFILES_ROOT
./install
```

### `./bootstrap`
Contains code that will bootstrap your entire system, including downloading the repo, unpacking it, adding `$DOTFILE_ROOT` to `.localrc`, running `./install` and running `./dotfiles`.
