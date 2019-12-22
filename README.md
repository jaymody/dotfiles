# dotfiles

A git repo for all my dotfiles.

Heavily inspired by https://github.com/holman/dotfiles.git, it's a great repo, go check it out.


## install
```sh
echo "export DOTFILES_ROOT=path/to/where/you/want/to/save/this/repo/" >> ~/.localrc # I recommend saving it to ~/.dotfiles
source ~/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
```

## usage

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH`.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment via `source *.zsh`.
- **topic/init.zsh**: Any file named `init.zsh` is loaded first (might be needed to set up a `$PATH` or similar for other .zsh files in same the topic directory).
- **topic/install.sh**: Any file named `install.sh` is executed when you run `install`. These need to manually added to the install script since order matters (technically you can name `topic/install.sh` anything as long as the right reference is made in `./install`)
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `dotfiles`.

On a fresh install of a system run the following to install homebrew, setup your system preferences, apps, etc ... :
```sh
cd $DOTFILES_ROOT
./install
```

To source/symlink/update your system with the dotfiles repo run:
```sh
cd $DOTFILES_ROOT
./dotfiles
```
