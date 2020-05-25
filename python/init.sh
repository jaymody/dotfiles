# pyenv
export PATH="${HOME}/.pyenv/bin:$PATH"


if [ -x "$(command -v pyenv)" ]; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# nltk
export NLTK_DATA="${CODE_DIR_RES}/nltk_data"
