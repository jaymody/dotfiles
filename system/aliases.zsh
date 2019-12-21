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
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi
alias l="ls -A1 ${colorflag}"
alias la="ls -A ${colorflag}"
alias ll="ls -Al ${colorflag}"
alias lsd="ls -F1 ${colorflag} | grep --color=never '^d'"
alias ls="command ls ${colorflag}"

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
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias reload="exec ${SHELL} -l"
alias paths='echo -e ${PATH//:/\\n}'

# shortcuts
alias dcode="cd ~/code"
alias dr="cd ~/drive"
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"

# apps
alias chrome='open -n "/Applications/Google Chrome.app"'

# ssh
alias moore='ssh -X modyj@moore.mcmaster.ca'
alias mserv='ssh modyj@mserv.magarveylab.ca'
alias sesame-vm='gcloud compute ssh --project magarvey-dl --zone us-central1-a sesame-vm'
alias sesame-vm-openport='gcloud compute ssh --project magarvey-dl --zone us-central1-a sesame-vm -- -L localhost:7001:localhost:7001'
alias valerievm='gcloud compute ssh jaykmody@instance-1-vm --zone=us-central1-a'
