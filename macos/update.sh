# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
    exit
fi

# alfred
rm -rf ${DOTFILES_ROOT}/macos/alfred
cp -r "${HOME}/Library/Application Support/Alfred/Alfred.alfredpreferences/preferences" ${DOTFILES_ROOT}/macos/alfred
