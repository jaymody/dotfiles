# check direnv is installed
if ! [ -x "$(command -v gcloud)" ]; then
    return
fi

# use system python (which is likely python 2.7) so we don't
# need backup python2 in pyenv
export CLOUDSDK_PYTHON="/usr/bin/python2"
