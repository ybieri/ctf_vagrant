#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export UCF_FORCE_CONFOLD=1

# Updates
sudo -E apt-get -y update
sudo -E apt-get -y upgrade

sudo -E apt-get -y install python3-pip
sudo -E apt-get -y install gdb gdb-multiarch
sudo -E apt-get -y install unzip
sudo -E apt-get -y install foremost
sudo -E apt-get -y install htop
sudo -E apt-get -y install terminator

# install GUI
sudo -E apt-get -y install ubuntu-desktop
sudo -E apt-get -y install virtualbox-guest-dkms
sudo -E apt-get -y install virtualbox-guest-utils
sudo -E apt-get -y install virtualbox-guest-x11
sudo -E sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
#config.vm.provision "shell", inline: "sudo -E apt-get install -y lightdm lightdm-gtk-greeter

# Remove amazon from GUI
sudo -E apt purge -y ubuntu-web-launchers

# Install Java for ghidra
sudo -E add-apt-repository ppa:linuxuprising/java
sudo -E apt-get update
echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | sudo -E /usr/bin/debconf-set-selections
sudo -E apt-get -y install oracle-java11-installer


# Install ARM/MIPS support - https://ownyourbits.com/2018/06/13/transparently-running-binaries-from-any-architecture-in-linux-with-qemu-and-binfmt_misc/
sudo -E apt-get -y install gcc-arm-linux-gnueabihf
sudo -E apt-get -y install qemu qemu-user qemu-user-static
sudo -E apt-get -y install debian-keyring
sudo -E apt-get -y install debian-archive-keyring
sudo -E apt-get -y install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
sudo -E apt-get -y install libc6-mipsel-cross
sudo -E apt-get -y install libc6-arm64-cross libc6-armhf-cross libc6-armel-armhf-cross libc6-armel-cross libc6-armhf-armel-cross
echo "export QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf" >> /home/vagrant/.zshrc




# These are so the 64 bit vm can build 32 bit
sudo -E apt-get -y install libx32gcc-4.8-dev
sudo -E apt-get -y install libc6-dev-i386


# Install Pwntools
sudo -E apt-get -y install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo -E -H pip install --upgrade pip
sudo -E -H pip install --upgrade pwntools



cd
mkdir tools
cd tools

# Install capstone
sudo -E apt-get install libcapstone-dev

# Install pwndbg
git clone https://github.com/zachriggle/pwndbg
cd pwndbg
./setup.sh

# Install pwndbg for root
sudo -E su << HERE
git clone https://github.com/zachriggle/pwndbg
cd pwndbg
./setup.sh
HERE


# pycparser for pwndbg
sudo -E -H pip3 install pycparser # Use pip3 for Python3

# Install binwalk
cd tools
git clone https://github.com/devttys0/binwalk
cd binwalk
sudo -E python setup.py install

# Install Firmware-Mod-Kit
sudo -E apt-get -y install git build-essential zlib1g-dev liblzma-dev python-magic
cd ~/tools
git clone https://github.com/rampageX/firmware-mod-kit.git


# oh-my-zsh
sudo -E apt-get -y install zsh
echo vagrant | sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Angr
cd /home/vagrant/tools
sudo -E apt-get -y install python-dev libffi-dev build-essential virtualenvwrapper
sudo -E -H pip install virtualenv
virtualenv angr
source angr/bin/activate
pip install angr --upgrade


# Enable 32bit binaries on 64bit host
sudo -E dpkg --add-architecture i386
sudo -E apt-get -y update
sudo -E apt-get -y upgrade
sudo -E apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386


# Install z3 theorem prover
#cd tools
#git clone https://github.com/Z3Prover/z3.git && cd z3
#python scripts/mk_make.py
#cd build
#make
#sudo -E make install


# Install binary ninja
mkdir /home/vagrant/tools/binaryninja

# Install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo -E apt-key add -
sudo -E apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo -E apt-get update
sudo -E apt-get -y install libgtk2.0-0
sudo -E apt-get -y install sublime-text
mkdir -p /home/vagrant/.config/sublime-text-3/Local

# Install chromium
sudo -E apt-get install -y chromium-browser

# Install one_gadget
sudo -E apt install ruby-full
sudo -E gem install one_gadget

# Add ghidra alias
echo "alias ghidra='/home/vagrant/tools/ghidra_9.0/ghidraRun'" >> /home/vagrant/.zshrc
