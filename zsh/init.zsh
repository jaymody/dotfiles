# oh-my-zsh settings
export ZSH="$DOTFILES_ROOT/zsh/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(z git virtualenv docker pyenv python screen gcloud zsh-autosuggestions)

# load oh-my-zsh while ignoring aliases
save_aliases=$(alias -L)
source $ZSH/oh-my-zsh.sh
unalias -m '*'
eval $save_aliases
unset save_aliases
alias ${_Z_CMD:-z}='_z 2>&1'

# load powerlevel10k config
source ~/.p10k.zsh

# terminal title
export DISABLE_AUTO_TITLE="true"
echo -e "\033];terminal\007"

# terminal colors
export TERM=xterm-256color
