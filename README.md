# dotfiles

~ sweet ~

## install
```shell
git clone https://github.com/jaymody/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap
```

**Note**: If you want to use a custom install location, you'll need to specify it as env variable in `~/.localrc`:
```shell
DOTFILES_ROOT="/path/to/dotfiles"
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
cd $DOTFILES_ROOT
./bootstrap
```
