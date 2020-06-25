# check github cli (hub) is installed
if ! [ -x "$(command -v hub)" ]; then
    return
fi

eval "$(hub alias -s)"
