# check vscode is installed
# assumes existent of code command means vscode is installed (yes, this is hacky)
if ! [ -x "$(command -v code)" ]; then
    echo "vscode is not installed or code command is not in path, skipping vscode setup ..."
    return
fi

# extensions
code --list-extensions > ${DOTFILES_ROOT}/vscode/extensions.txt

# settings.json
cp ${HOME}/Library/Application\ Support/Code/User/settings.json ${DOTFILES_ROOT}/vscode/settings.json

# keybindings.json
cp ${HOME}/Library/Application\ Support/Code/User/keybindings.json ${DOTFILES_ROOT}/vscode/keybindings.json

# snippets
cp -r ${HOME}/Library/Application\ Support/Code/User/snippets ${DOTFILES_ROOT}/vscode/
