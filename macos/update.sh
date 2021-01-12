# check os is darwin (macos)
if test "$(uname)" != "Darwin"; then
    return
fi

# save/update Brewfile
cd ${DOTFILES_ROOT}/macos
brew bundle dump --force

# better touch tool
echo "NOTE: unfortunately, there is no way to export bettertouchtools settings \
via command line, you'll have to save the preset manually"
