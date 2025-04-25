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
```

And that's it! Restart your shell/terminal and you should be good to go.

Or, try it out in docker first!:
```shell
docker run -e TERM -e COLORTERM -e LC_ALL=C.UTF-8 -it --rm alpine sh -uec '
  apk add alpine-sdk bash git zsh vim neovim
  git clone --recurse-submodules --shallow-submodule https://github.com/jaymody/dotfiles.git ~/.dotfiles
  printf "O" | ~/.dotfiles/link
  exec zsh'
```

For my machines/tools specific setups, see the [wiki](https://github.com/jaymody/dotfiles/wiki).
