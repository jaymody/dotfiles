# check vscode is installed
# assumes existent of code command means vscode is installed (yes, this is hacky)
if ! [ -x "$(command -v code)" ]; then
    exit
fi


# get vscode settings dir
if test "$(uname)" = "Darwin"; then
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
elif test "$(uname)" = "Linux"; then
    VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"
else
    echo "os must be darwin (macos) or linux to setup vscode."
    return
fi


# save extensions, settings, keybindings, and snippets
code --list-extensions > ${DOTFILES_ROOT}/vscode/extensions.txt
cp "${VSCODE_SETTINGS_DIR}/settings.json" ${DOTFILES_ROOT}/vscode/
cp "${VSCODE_SETTINGS_DIR}/keybindings.json" ${DOTFILES_ROOT}/vscode/
cp -r "${VSCODE_SETTINGS_DIR}/snippets" ${DOTFILES_ROOT}/vscode/
