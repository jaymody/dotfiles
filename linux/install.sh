# check os is linux
if test "$(uname)" != "Linux"; then
  	echo "os must be linux"
    return
fi


# this script currently only works on ubunutu

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
    screen


# # chrome setup
# wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# dpkg --install google-chrome-stable_current_amd64.deb
# rm google-chrome-stable_current_amd64.deb


# # docker setup - https://docs.docker.com/install/linux/docker-ce/ubuntu/
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt update -y
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io


# # visual studio dode setup - https://code.visualstudio.com/docs/setup/linux
# sudo snap install --classic code


# ubuntu-drivers (including CUDA)
# sudo ubuntu-drivers autoinstall


# node setup - https://github.com/nodesource/distributions/blob/master/README.md
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# sudo apt install -y nodejs

# gcloud sdk - https://cloud.google.com/sdk/docs/downloads-apt-get
# echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# sudo apt-get update && sudo apt-get install google-cloud-sdk

# cleanup
sudo apt autoremove -y
