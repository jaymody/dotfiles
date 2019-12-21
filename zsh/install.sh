sh -c "$(curl -fsSLo install-ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH="$DOTFILES_ROOT/zsh/oh-my-zsh" sh install-ohmyzsh.sh
rm install-ohmyzsh.sh
