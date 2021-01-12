# dotfiles

~ sweet ~

## install
You'll need to following before you can install:
* macos or linux
* bash
* git or curl
* sudo privileges (optional, only needed if using one of the setup scripts or bootstrap script)

### manual
Download the repo to `~/.dotfiles`:
```shell
git clone https://github.com/jaymody/dotfiles.git "${HOME}/.dotfiles"
```
For a custom install location, you'll need to specify it as env variable in `~/.localrc`:
```shell
DOTFILES_ROOT="/path/to/dotfiles"
echo "export DOTFILES_ROOT=\"$DOTFILES_ROOT\"" >> ${HOME}/.localrc
git clone https://github.com/jaymody/dotfiles.git $DOTFILES_ROOT
```

### bootstrap
TODO, but when done, it should be as simple as:
**Mac OS**
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jaymody/dotfiles/master/macos/bootstrap.sh"
```
For which, the install will provide configuration options.




