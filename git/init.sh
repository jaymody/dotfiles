# initialize github cli (hub) if installed
if [ -x "$(command -v hub)" ]; then
    eval "$(hub alias -s)"
fi
