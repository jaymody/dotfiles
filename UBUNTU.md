Setting up Ubuntu Server on my PC to make it into a GPU enabled deep learning machine that I can SSH into.

## 1) Install Ubuntu

1. [Download the desired Ubuntu ISO](https://releases.ubuntu.com/20.04/)
2. [Create a bootable USB Drive](https://ubuntu.com/tutorials/create-a-usb-stick-on-macos)
3. Plug in the USB and from the BIOS boot from the USB drive. You should just be able to just follow the instructions at this point, but here’s a link to the [guide](https://www.notion.so/Linux-Server-b8d925a7bdf244f6a8bb3647918d5ee2?pvs=21) if you need it. During the setup, I:
    1. Highly highly recommend installing on a completely separate hard drive ESPECIALLY if you are dual booting with windows (this will save you from pain and suffering when inevitably, one day you want to remove and/or reinstall linux from you dual booted device)
    - Use all default settings
    - If connected to wifi or ethernet, run updates
    - Don't install additional software

## 2) Basic Setup
```shell
# No more asking for password when using sudo
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER

# Update and upgrade packages.
sudo apt update -y && sudo apt upgrade -

# Disable cloud-init so we get faster startup time
sudo touch /etc/cloud/cloud-init.disabled

# On startup, if you're computer is not connected via ethernet, it will
# stall for 2 minutes saying "A start job is running for wait for
# network to be configured". To avoid this, we need to add the
# line "optional: true" to the corresponding ethernet device.
#
# See: https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1
sudo vim /etc/netplan/00-installer-config.yaml

# Reboot for changes to take affect.
sudo reboot
```

To connect via wifi instead of ethernet, try:
```shell
sudo apt install network-manager
nmtui
```

## 3) Setup SSH

Install and verify SSH is running:

```bash
sudo apt install openssh-server # might alread be installed
sudo systemctl status ssh # verify it is running
```

Get private ip (local ip) of linux server

```bash
hostname -I # should start with 192.168
```

Using another device connected to the same wifi network as the server, ssh into the server.

```bash
ssh username@local_ip
```

For better security, setup up ssh login via ssh key and then disable password login altogether. First, let's add our ssh key to the server. From your laptop:

```bash
ssh-copy-id 192.168.X.XX
```

Then, add the following to the bottom of `/etc/ssh/sshd_config:`

```bash
# Only allow ssh via ssh-key
PermitRootLogin no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
PubkeyAuthentication yes

# Keep idle ssh connections alive
ClientAliveInterval 60
TCPKeepAlive yes
ClientAliveCountMax 10
```

And apply these changes:

```shell
sudo netplan apply
```

Now, the machines local ip address may change every now and then, which is annoying. We should instead assign it a static ip by adding the following lines to the corresponding device in `/etc/netplan/00-installer-config-wifi.yaml` (`00-installer-config.yaml` if using ethernet):

```yaml
dhcp4: no
addresses: [192.168.X.XX/24] # replace with desired ip address
gateway4: 192.168.Y.YY # replace with output of ip route
nameservers:
  addresses: [8.8.4.4,8.8.8.8]
```

For more details [see this article](https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/). Then let's apply our changes once more.

```bash
sudo netplan apply
```

Verify that our static IP was added:

```bash
hostname -I
```

And finally, test our new static ip:

```bash
ssh username@static_ip
```

## 4) Github

Let's setup access to github so we can clone repos over ssh.

First, we generate an ssh key (passphrase is optional):
```shell
ssh-keygen -t rsa -b 4096
```

Then, we copy the output of:
```shell
cat ~/.ssh/id_rsa.pub
```

And [add it as new ssh key to our github](https://github.com/settings/ssh/new).

## 5) Dotfiles
See [github.com/jaymody/dotfiles](https://github.com/jaymody/dotfiles)

Zsh is probably not installed, so we'll need to run before setting up the dotfiles:
```shell
sudo apt install zsh
```

## 6) Deep Learning Stuff
TODO
