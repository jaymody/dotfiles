# HISTFILE=~/.zsh_history
HISTSIZE=64000
SAVEHIST=64000

# zsh options
# type setopt in terminal for active settings
# (https://linux.die.net/man/1/zshoptions)
# (https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_17.html)

# # don't expand aliases _before_ completion has finished
# #   like: git comm-[tab]
# setopt complete_aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
# bindkey '^[[5D' beginning-of-line
# bindkey '^[[5C' end-of-line
# bindkey '^[[3~' delete-char
# bindkey '^?' backward-delete-char

# better history (https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "^[p" history-beginning-search-backward
bindkey "^[n" history-beginning-search-forward
