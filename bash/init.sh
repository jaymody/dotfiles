# check bash is current shell
if ! test -n "$BASH_VERSION"; then
    return
fi

# prompt
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
