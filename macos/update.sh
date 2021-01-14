# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
    exit
fi

# save/update Brewfile
cd ${DOTFILES_ROOT}/macos
brew bundle dump --force

# better touch tool
echo "NOTE: unfortunately, there is no way to export bettertouchtools settings \
via command line, you'll have to save the preset manually"

# alfred
rm -rf ${DOTFILES_ROOT}/macos/alfred
cp -r "${HOME}/Library/Application Support/Alfred/Alfred.alfredpreferences/preferences" ${DOTFILES_ROOT}/macos/alfred
