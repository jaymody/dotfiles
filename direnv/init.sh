# check direnv is installed
if ! [ -x "$(command -v direnv)" ]; then
    return
fi

# initialize direnv (https://direnv.net/docs/hook.html)
if test -n "$ZSH_VERSION"; then
    eval "$(direnv hook zsh)"
elif test -n "$BASH_VERSION"; then
    eval "$(direnv hook bash)"
fi


# silence the annoying direnv logs (we already have the p10k direnv segment)
export DIRENV_LOG_FORMAT=
