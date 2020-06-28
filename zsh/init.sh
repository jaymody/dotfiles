# check zsh is current shell
if ! test -n "$ZSH_VERSION"; then
    return
fi


# oh-my-zsh settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(z zsh-autosuggestions zsh-syntax-highlighting)


# load oh-my-zsh while ignoring aliases
save_aliases=$(alias -L)
source $ZSH/oh-my-zsh.sh
unalias -m '*'
eval $save_aliases
unset save_aliases
alias ${_Z_CMD:-z}='_z 2>&1'


# load powerlevel10k config
source ${HOME}/.p10k.zsh


# terminal title
export DISABLE_AUTO_TITLE="true"
echo -e "\033];terminal\007"


# terminal colors
export TERM=xterm-256color


# load zsh config
source ${DOTFILES_ROOT}/zsh/config.sh
