# dotfiles

A git repo for all my dotfiles (and more).

Heavily inspired by https://github.com/holman/dotfiles.git, it's a great repo, go check it out.


## install
### via git
```sh
git clone https://github.com/jaymody/dotfiles.git "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles"
./bootstrap  # bootstrap system (install/setup apps, os, and other software)
./dotfiles   # symlink dotfiles from repo to home dir
```

### custom install location
The default location for dotfiles is `${HOME}/.dotfiles`. If you want to use a custom location, you'll need to specify it's location via the `DOTFILES_ROOT` environment variable that must be set in `${HOME}/.localrc`:
```sh
DOTFILES_ROOT="${HOME}/.dotfiles" # replace with your custom location here
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
source ${HOME}/.localrc

git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
cd $DOTFILES_ROOT
./bootstrap  # bootstrap system (install/setup apps, os, and other software)
./dotfiles   # symlink dotfiles from repo to home dir
```

### via curl
Alternatively, instead of using git, you can use curl:
```sh
DOTFILES_ROOT="${HOME}/.dotfiles" # replace with your custom location here
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
source ${HOME}/.localrc

curl -LO https://github.com/jaymody/dotfiles/archive/master.zip
unzip master.zip
rm master.zip
mv dotfiles-master $DOTFILES_ROOT

cd $DOTFILES_ROOT
./bootstrap  # bootstrap system (install/setup apps, os, and other software)
./dotfiles   # symlink dotfiles from repo to home dir
```

## usage

The main difference between this repo vs other dotfiles repos is that there is a heavy emphasis on containing everything into "topic" areas (ie zsh, bash, python, etc ...).

Each topic can have the following special file types:
1. **`topic/*.symlink`**: When `./dotfiles` is run, these files will get symlinked into your `$HOME` dir. This way, you can keep all your dotfiles organized and versioned controled in this repo while still using them in your `$HOME` dir.
2. **`topic/init.sh`**: When a shell instance is opened, these files are sourced. This is used to intialize anything needed for a given topic to run. For example, if you're using `pyenv`, this is where you would put `eval "$(pyenv init -)"`.
3. **`topic/aliases.sh`**: When a shell instance is opened, these files are sourced. This is where you should put aliases (you could also put the aliases in the `init.sh` files, but I like to keep my aliases seperate since there can be many of them).
4. **`topic/setup.sh`**: When `./install` is run, this file is run as a script. This should be a one time operation when you setup your machine as it is intended to setup/install the topic.
5. **`topic/update.sh`**: When `./update` is run, this file is run as a script. This is used to update any config files for the topic. For example, for the macos topic, this is used to save a `Brewfile` of all the latest packages/apps that are installed via homebrew. Run `./update` and git commit every now and then to make sure all your settings are backed up.

In addition, there are a couple of special files/folders:
1. **`macos/install.sh`**: If on Mac, when `./install` is run, this file is run as a script (before the `setup.sh` scripts). This will install homebrew, brew install apps/packages via the saved `Brewfile`, as well as setup things like `iterm2` settings, macos defaults, etc ...
2. **`linux/install.sh`**: If on Linux, when `./install` is run, this file is run as a script (before the `setup.sh` scripts). This will install apps/packages via apt and snap, as well as other linux related stuff.
3. **`bin/`**: When a shell instance is opened, this is added to your `$PATH`. This is where you can put your scripts and tricks.
4. **`system/shellrc.symlink`**: This is a symlinked dotfile, however it is special than the others because this is the script that is the entry point for all your shells. This is where all the `init.sh` and `aliases.sh` files are searched for and sourced on startup. `bashrc`, `zshrc`, and any other shell rc file should source `${HOME}/.shellrc` and do nothing else. Code specific to each shell (ie zsh defaults, oh-my-zsh init) should be placed in their corresponding `init.sh` files instead.

The advantages this design philosophy is:
1. Everything is contained within it's own topic folder which allows for modular installs. Each `init.sh` script checks if the current topic is avaliable, meaning `init.sh` for docker won't run if docker is not installed. This is also done for the `setup.sh` and `update.sh` scripts. You no longer have to go digging into you're 400+ line long mess of a .bashrc to comment out `eval "$(pyenv init -)"` because you're on a ubuntu server where pyenv isn't installed and you're not the admin.
2. Everything is neatly organized, don't you agree.
