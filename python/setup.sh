# install pyenv if not mac and is not already installed
if [ ! -x "$(command -v pyenv)" ]; then
    if test "$(uname)" = "Darwin"; then
        brew install pyenv pyenv-virtualenv
    fi
    if test "$(uname)" = "Linux"; then
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    fi
fi
