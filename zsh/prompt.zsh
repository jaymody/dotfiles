# oh-my-zsh
export ZSH="$DOTFILES_ROOT/zsh/oh-my-zsh" 
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git virtualenv docker pyenv python screen gcloud zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh

# better title
# function title() {
#   # escape '%' chars in $1, make nonprintables visible
#   a=${(V)1//\%/\%\%}

#   # Truncate command, and join lines.
#   a=$(print -Pn "%40>...>$a" | tr -d "\n")

#   case $TERM in
#   screen)
#     print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
#     ;;
#   xterm*|rxvt)
#     print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
#     ;;
#   esac
# }
