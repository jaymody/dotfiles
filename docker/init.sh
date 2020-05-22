# check docker-machine is installed
if ! [ -x "$(command -v docker-machine)" ]; then
    return
fi


# eval "$(docker-machine env default)"
