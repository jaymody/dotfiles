# check os is linux
if test "$(uname)" != "Linux"; then
  	echo "os must be linux"
    return
fi


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
    software-properties-common


# # chrome setup
# wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# dpkg --install google-chrome-stable_current_amd64.deb
# rm google-chrome-stable_current_amd64.deb


# # docker setup - https://docs.docker.com/install/linux/docker-ce/ubuntu/
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# apt update -y
# apt-get install -y docker-ce docker-ce-cli containerd.io


# # visual studio dode setup - https://code.visualstudio.com/docs/setup/linux
# sudo snap install --classic code


# node setup - https://github.com/nodesource/distributions/blob/master/README.md
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt install -y nodejs


# cleanup
sudo apt autoremove -y
