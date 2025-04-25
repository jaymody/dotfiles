# dotfiles

~ sweet ~

## install
Clone the repo (I recommend cloning to `~/.dotfiles` but you can put it wherever you like):
```shell
git clone --recurse-submodules --shallow-submodule https://github.com/jaymody/dotfiles.git ~/.dotfiles
```

Symlink files from `dotfiles` to your home directory:
```shell
./link
```

Make `zsh` your default shell:
```shell
chsh -s $(which zsh)
exec shell
```

And that's it! Restart your shell/terminal and you should be good to go.

There's also a [wiki](https://github.com/jaymody/dotfiles/wiki) that contains guides on how I set up my various machines.
