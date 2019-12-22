# install oh-my-zsh
sh -c "$(curl -fsSLo install-ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH="$DOTFILES_ROOT/zsh/oh-my-zsh" sh install-ohmyzsh.sh
rm install-ohmyzsh.sh

# install plugins/themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH}/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/custom/plugins/zsh-autosuggestions
