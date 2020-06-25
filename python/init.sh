# pyenv
export PATH="${HOME}/.pyenv/bin:$PATH"
if [ -x "$(command -v pyenv)" ]; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# nltk
export NLTK_DATA="${HOME}/code/res/nltk_data"
