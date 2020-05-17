# check vscode is installed
# assumes existent of code command means vscode is installed (yes, this is hacky)
if ! [ -x "$(command -v code)" ]; then
    echo "vscode is not installed or code command is not in path, skipping vscode setup ..."
    return
fi


# install vscode extensions
cat ${DOTFILES_ROOT}/vscode/extensions.txt | xargs -L 1 echo code --install-extension

echo "NOTE: to finish vscode setup, manually "
