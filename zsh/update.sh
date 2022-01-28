# check zsh is installed
if ! [ -x "$(command -v zsh)" ]; then
    exit
fi

echo "updating oh-my-zsh"
cd $ZSH
git pull

echo "updating zsh-autosuggestions"
cd ${ZSH}/custom/plugins/zsh-autosuggestions
git pull

echo "updating powerlevel10k"
cd ${ZSH}/custom/themes/powerlevel10k
git pull

echo "updating zsh-syntax-highlighting"
cd ${ZSH}/custom/plugins/zsh-syntax-highlighting
git pull

echo "updating git-open"
cd ${ZSH}/custom/plugins/git-open
git pull

echo "updating autoswitch-virtualenv"
cd ${ZSH}/custom/plugins/autoswitch_virtualenv
git pull
