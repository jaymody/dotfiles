#!/bin/bash

if [ -d ${DOTFILES_ROOT}/bin ]; then
	cd $DIR
else
	echo 'error, could not find ${DOTFILES_ROOT}/bin'
	exit 1
fi


if [ $# -eq 0 ]; then
	echo "Command requires at least 1 argument [filename]"
	exit 1
fi

if [ -f "$1" ]; then
	echo "$1 script already exists"
	exit 1
else
	touch $1
	chmod 755 $1
	echo "#!/bin/bash" > $1
	echo "" >> $1
	$EDITOR ${DOTFILES_ROOT}/bin
	$EDITOR $1
fi
