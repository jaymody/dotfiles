# check docker-machine is installed
if ! [ -x "$(command -v docker-machine)" ]; then
    echo "docker-machine is not installed, skipping docker-machine setup ..."
    return
fi


# create default docker machine
docker-machine create default
