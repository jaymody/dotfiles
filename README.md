# dotfiles

A git repo for all my dotfiles (and more).

Heavily inspired by https://github.com/holman/dotfiles.git, it's a great repo, go check it out.


## install
Before you can install, you'll need the following:
- macos or linux
- bash
- sudo
- git (or alternatively curl/unzip)

### download
#### via git
```sh
git clone https://github.com/jaymody/dotfiles.git "${HOME}/.dotfiles"
```

#### via curl
Alternatively, instead of using git, you can use curl (NOTE: this will not download the `.git` folder):
```sh
curl -LO https://github.com/jaymody/dotfiles/archive/master.zip
unzip master.zip
rm master.zip
mv dotfiles-master $DOTFILES_ROOT
```

#### custom install location
The default location for dotfiles is `${HOME}/.dotfiles`. If you want to use a custom location, you'll need to specify it's location via the `DOTFILES_ROOT` environment variable that must be set in `${HOME}/.localrc`:
```sh
DOTFILES_ROOT="${HOME}/.dotfiles" # replace with your custom location here
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
source ${HOME}/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
```

### install
Link dotfiles to home directory:
```sh
./dotfiles
```
Run macos or linux install scripts:
```sh
bash linux/install.sh
bash macos/install.sh
```
Run setup script for a given tool:
```sh
bash zsh/setup.sh
bash vscode/setup.sh
...
```

## usage

The main feature of this dotfiles setup is that all your configs/scripts/files are contained within "topic" folders (ie zsh, bash, python, etc ...), allowing everything to be neatly organized and contained.

There are 5 special types of files that can be placed inside a topic folder:
1. **`topic/*.symlink`**: These files will get symlinked into your `$HOME` directory (ie `bash/bashrc.symlink` will be symlinked to `$HOME/.bashrc`. This symlink is done via `./dotfiles` script.
2. **`topic/init.sh`**: When a shell instance is opened, these files are sourced. Use these scripts to initialize env variables, configs, tools, etc ... For example, if you're using `pyenv`, this is where you would put `eval "$(pyenv init -)"`.
3. **`topic/aliases.sh`**: When a shell instance is opened, these files are sourced. This is where you should put aliases (you could also put the aliases in the `init.sh` files, but I like to keep my aliases separated).
4. **`topic/setup.sh`**: These files are intended to be install/setup scripts for a given tool. They only need to be run once, and must be run manually via the command line.
5. **`topic/update.sh`**: These files are intended to make things update, as well as save the latest versions of your config files to the repo (ie, things like new apps that would appear in you `Brewfile`, or fetching the most updated `settings.json` from vscode into the dotfiles repo. You should run `./update` and git commit/push regularly to make sure all your settings are updated and backed up. Better yet, create a cronjob to do it for you.

In addition, there are a couple of special files/folders:
1. **`macos/install.sh`**: If on Mac, when `./install` is run, this file is run as a script (before the `setup.sh` scripts). This will install homebrew, brew install apps/packages via the saved `Brewfile`, as well as setup things like `iterm2` settings, macos defaults, etc ...
2. **`linux/install.sh`**: If on Linux, when `./install` is run, this file is run as a script (before the `setup.sh` scripts). This will install apps/packages via apt and snap, as well as other linux related stuff.
3. **`bin/`**: When a shell instance is opened, this is added to your `$PATH`. This is where you can put your scripts and tricks.
4. **`system/shellrc.symlink`**: This is a symlinked dotfile, however it is special than the others because this is the script that is the entry point for all your shells. This is where all the `init.sh` and `aliases.sh` files are searched for and sourced on startup. `bashrc`, `zshrc`, and any other shell rc file should source `${HOME}/.shellrc` and do nothing else. Code specific to each shell (ie zsh defaults, oh-my-zsh init) should be placed in their corresponding `init.sh` files instead.

The advantages of this design philosophy is:
1. Everything is contained within it's own topic folder which enables modularity. Each `init.sh` script checks if the current topic is available, meaning `init.sh` for docker won't run if docker is not installed. This is also done for the `setup.sh` and `update.sh` scripts. You no longer have to go digging into you're 400+ line long mess of a .bashrc to comment out `eval "$(pyenv init -)"` because you're on a ubuntu server where pyenv.
2. Everything is neatly organized, dare I say, clean.
