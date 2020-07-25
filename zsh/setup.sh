# check zsh is installed
if ! [ -x "$(command -v zsh)" ]; then
    echo "zsh is not installed, skipping zsh setup ..."
    exit 1
fi


# install oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export KEEP_ZSHRC=yes
export RUNZSH=no
curl -fsSLo install-ohmyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install-ohmyzsh.sh
rm install-ohmyzsh.sh


# install plugins/themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH}/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/custom/plugins/zsh-syntax-highlighting


# install powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
