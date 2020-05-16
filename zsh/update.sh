echo "updating oh-my-zsh"
cd $ZSH
git pull

echo "updating zsh-autosuggestions"
cd ${ZSH}/custom/plugins/zsh-autosuggestions
git pull

echo "updating powerlevel10k"
cd ${ZSH}/custom/themes/powerlevel10k
git pull
