# check direnv is installed
if ! [ -x "$(command -v gcloud)" ]; then
    return
fi

# use system python2 for gcloud since active python will probably be python3
export CLOUDSDK_PYTHON="/usr/bin/python2"
