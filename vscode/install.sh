# Install vscode extensions
cat ${DOTFILES_ROOT}/vscode/extensions.txt | xargs -L 1 echo code --install-extension
