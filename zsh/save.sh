echo "updating oh-my-zsh"
cd $DOTFILES_ROOT/zsh/oh-my-zsh
git pull

echo "updating zsh-autosuggestions"
cd $DOTFILES_ROOT/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
git pull

echo "updating powerlevel10k"
cd $DOTFILES_ROOT/zsh/oh-my-zsh/custom/themes/powerlevel10k
git pull
