# dotfiles
alias dotfiles='cd $DOTFILES_ROOT'
alias edotfiles='$EDITOR $DOTFILES_ROOT'
alias scripts='cd $DOTFILES_ROOT/bin'
alias escripts='$EDITOR $DOTFILES_ROOT/bin'

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias ~="cd ~"

# ls
export LS_COLORS="di=1;36:ln=0;44:so=32:pi=31:ex=35:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

if ls --color > /dev/null 2>&1; then
    lsflag="ls"
else
    lsflag="gls"
fi

alias ls="$lsflag --color --group-directories-first"
alias l="$lsflag -1 --color --group-directories-first"
alias la="$lsflag -A1 --color --group-directories-first"
alias ll="$lsflag -Ahl --color --group-directories-first"

# network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# show/hide desktop
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# misc
alias q='exit'
alias cls='clear'
alias duh="du -csh * | sort -rh"
alias tsv='function __tsv() { column -t $* | less; unset -f __tsv; }; __tsv'
alias csv='function __csv() { column -s, -t < $* | less -#2 -N -S; unset -f __csv; }; __csv'
alias json='function __json() { jq -C . $* | less -R; unset -f __json; }; __json'
alias paths='echo -e ${PATH//:/\\n}'
alias reload="exec ${SHELL} -l"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias closewin="osascript -e 'tell application \"Finder\" to close windows'"

# ssh
alias mserv='ssh jay@magarveylab-computational.mcmaster.ca'
alias sesame-vm='gcloud compute ssh --project magarvey-dl --zone us-central1-a sesame-vm'
alias sesame-vm-openport='gcloud compute ssh --project magarvey-dl --zone us-central1-a sesame-vm -- -L localhost:7001:localhost:7001'
alias moore='ssh modyj@moore.mcmaster.ca'
alias mills='ssh modyj@mills.mcmaster.ca'
alias valerievm='gcloud compute ssh jaykmody@testing-vm'
