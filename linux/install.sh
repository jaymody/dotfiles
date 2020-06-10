# check os is linux
if test "$(uname)" != "Linux"; then
  	echo "os must be linux"
    return
fi


# this script is built for ubuntu only
# parts of script taken from:
# https://github.com/paulkohler/ubuntu-linux-bootstrap/blob/master/bootstrap.sh


# update/upgrade
sudo apt update -y
sudo apt upgrade -y


# essentials
sudo apt install -y \
    git \
    zsh \
    curl \
    wget \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    xclip \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    ubuntu-drivers-common \
    python2 \
    screen \
    tree


# chrome setup
function install_chrome() {
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg --install google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
}


# pyenv setup - https://github.com/pyenv/pyenv-installer
function install_pyenv() {
    curl https://pyenv.run | bash
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
}

# docker setup - https://docs.docker.com/install/linux/docker-ce/ubuntu/
function install_docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}


# visual studio code setup - https://code.visualstudio.com/docs/setup/linux
function install_vscode() {
    sudo snap install --classic code
}

# node setup - https://github.com/nodesource/distributions/blob/master/README.md
function install_node() {
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
}


# gcloud sdk - https://cloud.google.com/sdk/docs/downloads-apt-get
function install_gcloud() {
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update && sudo apt-get install google-cloud-sdk
}


# ubuntu-drivers (ie nvidia-drivers, CUDA, etc ...)
function install_ubuntu_drivers() {
    sudo ubuntu-drivers autoinstall
}


function _install() {
    # first param is message for user, second param is install function to execute
    printf "\r  [ \033[0;33m??\033[0m ] ${1} [y/n]\n"
    read -n 1 action

    case "$action" in
        y )
        $1;;
        n )
        return;;
        * )
        ;;
    esac
}


# ask for installations
_install install_chrome
_install install_pyenv
_install install_docker
_install install_vscode
_install install_node
_install install_gcloud
_install install_ubuntu_drivers


# cleanup
sudo apt autoremove -y
