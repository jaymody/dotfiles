# initialize direnv (https://direnv.net/docs/hook.html)
eval "$(direnv hook ${SHELL})"

# silence the annoying direnv logs (we already have the p10k direnv segment)
export DIRENV_LOG_FORMAT=
