# dotfiles

~ sweet ~

## installation
### requirements
* macos or linux
* bash
* git or curl
* sudo privileges (optional, only needed if using one of the setup scripts or bootstrap script)

### download
```shell
git clone https://github.com/jaymody/dotfiles.git "${HOME}/.dotfiles"
```

**Note**: If you want to use a custom install location, you'll need to specify it as env variable in `~/.localrc`:
```shell
DOTFILES_ROOT="/path/to/dotfiles"
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
```

### install
```shell
./bootstrap
```

### update
```shell
./update
```
