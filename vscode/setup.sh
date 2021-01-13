# check vscode is installed
# assumes existent of code command means vscode is installed (yes, this is hacky)
if ! [ -x "$(command -v code)" ]; then
    echo "vscode is not installed or code command is not in path, skipping vscode setup ..."
    exit
fi

# setup extensions, settings, keybindings, and snippets
if test "$(uname)" = "Darwin"; then
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User/"
elif test "$(uname)" = "Linux"; then
    VSCODE_SETTINGS_DIR="$HOME/.config/Code/User/settings.json"
else
    echo "os must be darwin (macos) or linux to setup vscode."
    exit
fi

cat ${DOTFILES_ROOT}/vscode/extensions.txt | xargs -L 1 code --install-extension
cp ${DOTFILES_ROOT}/vscode/settings.json "${VSCODE_SETTINGS_DIR}"
cp ${DOTFILES_ROOT}/vscode/keybindings.json "${VSCODE_SETTINGS_DIR}"
cp -r ${DOTFILES_ROOT}/vscode/snippets "${VSCODE_SETTINGS_DIR}"
