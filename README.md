# dotfiles

~ sweet ~

## install
Clone the repo (I recommend cloning to `~/.dotfiles` but you can put it wherever you like):
```shell
git clone git@github.com:jaymody/dotfiles.git ~/.dotfiles
```

Change `zsh` to default shell:
```shell
chsh -s $(which zsh)
```

Clone ZSH theme and plugins:
```shell
DIR="${HOME}/.dotfiles-local"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${DIR}/powerlevel10k"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${DIR}/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${DIR}/zsh-syntax-highlighting"
```

Link files in the `dotfiles` folder to `~` and folders in `config` to `~/.config`:
```shell
./link
```

There's also a [wiki](https://github.com/jaymody/dotfiles/wiki) that contains guides on how I set up my various machines.

