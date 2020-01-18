# oh-my-zsh
export ZSH="$DOTFILES_ROOT/zsh/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(z git virtualenv docker pyenv python screen gcloud zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh

# title
export DISABLE_AUTO_TITLE="true"
echo -e "\033];terminal\007"
