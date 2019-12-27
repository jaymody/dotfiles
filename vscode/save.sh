# extensions
code --list-extensions > ${DOTFILES_ROOT}/vscode/extensions.txt

# settings.json
cp ~/Library/Application\ Support/Code/User/settings.json ${DOTFILES_ROOT}/vscode/settings.json

# keybindings.json
cp ~/Library/Application\ Support/Code/User/keybindings.json ${DOTFILES_ROOT}/vscode/keybindings.json

# snippets
cp -r ~/Library/Application\ Support/Code/User/snippets ${DOTFILES_ROOT}/vscode/
