# check os is linux
if test "$(uname)" != "Linux"; then
  	echo "os must be linux"
    return
fi


# exit script if command fails
set -e


# this script is built for ubuntu only
# parts of script taken from:
# https://github.com/paulkohler/ubuntu-linux-bootstrap/blob/master/bootstrap.sh


# update/upgrade
sudo apt update -y
sudo apt upgrade -y


# essentials
sudo apt install -y \
    coreutils \
    net-tools \
    build-essential \
    make \
    openssl \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    git \
    curl \
    wget


# extras
sudo apt install -y \
    ubuntu-drivers-common \
    zsh \
    xclip \
    vim \
    python \
    screen \
    tmux \
    tree \
    direnv \
    zip \
    unzip \
    jq \
    htop \
    ack


# chrome setup
install_chrome() {
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg --install google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
}


# pyenv setup - https://github.com/pyenv/pyenv-installer
install_pyenv() {
    curl https://pyenv.run | bash
}

# docker setup - https://docs.docker.com/install/linux/docker-ce/ubuntu/
install_docker() {
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}


# visual studio code setup - https://code.visualstudio.com/docs/setup/linux
install_vscode() {
    sudo snap install --classic code
}


# node setup - https://github.com/nodesource/distributions/blob/master/README.md
install_node() {
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
}


# nvm setup - https://github.com/nvm-sh/nvm
install_nvm() {
    PROFILE="/dev/null/" # disable editing of .zshrc, .bashrc, or equivalent
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
}


# gcloud sdk - https://cloud.google.com/sdk/docs/downloads-apt-get
install_gcloud() {
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update -y && sudo apt-get install -y google-cloud-sdk
}


# ubuntu-drivers (ie nvidia-drivers, CUDA, etc ...)
install_ubuntu_drivers() {
    sudo ubuntu-drivers autoinstall
}


_install() {
    printf "\r  [ \033[0;33m??\033[0m ] ${1} [y/n]: "
    local action=
    read action

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
_install install_nvm
_install install_gcloud
_install install_ubuntu_drivers


# cleanup
sudo apt autoremove -y
