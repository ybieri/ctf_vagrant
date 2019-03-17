#!/bin/bash


# Updates
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install python3-pip
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install unzip
sudo apt-get -y install foremost
sudo apt-get -y install htop
sudo apt-get -y install terminator

# install GUI
sudo apt-get -y install ubuntu-desktop
sudo apt-get -y install virtualbox-guest-dkms
sudo apt-get -y install virtualbox-guest-utils
sudo apt-get -y install virtualbox-guest-x11
sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
#config.vm.provision "shell", inline: "sudo apt-get install -y lightdm lightdm-gtk-greeter

# Remove amazon from GUI
sudo apt purge -y ubuntu-web-launchers

# Install Java for ghidra
sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get update
echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java11-installer


# Install ARM/MIPS support - https://ownyourbits.com/2018/06/13/transparently-running-binaries-from-any-architecture-in-linux-with-qemu-and-binfmt_misc/
sudo apt-get -y install gcc-arm-linux-gnueabihf
sudo apt-get -y install qemu qemu-user qemu-user-static
sudo apt-get -y install debian-keyring
sudo apt-get -y install debian-archive-keyring
sudo apt-get -y install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
sudo apt-get -y install libc6-mipsel-cross
sudo apt-get -y install libc6-arm64-cross libc6-armhf-cross libc6-armel-armhf-cross libc6-armel-cross libc6-armhf-armel-cross
echo "export QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf" >> /home/vagrant/.zshrc




# These are so the 64 bit vm can build 32 bit
sudo apt-get -y install libx32gcc-4.8-dev
sudo apt-get -y install libc6-dev-i386


# Install Pwntools
sudo apt-get -y install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade pwntools



cd
mkdir tools
cd tools

# Install capstone
sudo apt-get install libcapstone-dev

# Install pwndbg
git clone https://github.com/zachriggle/pwndbg
cd pwndbg
./setup.sh

# Install pwndbg for root
sudo su << HERE
git clone https://github.com/zachriggle/pwndbg
cd pwndbg
./setup.sh
HERE


# pycparser for pwndbg
sudo -H pip3 install pycparser # Use pip3 for Python3

# Install binwalk
cd tools
git clone https://github.com/devttys0/binwalk
cd binwalk
sudo python setup.py install

# Install Firmware-Mod-Kit
sudo apt-get -y install git build-essential zlib1g-dev liblzma-dev python-magic
cd ~/tools
git clone https://github.com/rampageX/firmware-mod-kit.git


# oh-my-zsh
sudo apt-get -y install zsh
echo vagrant | sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Angr
cd /home/vagrant/tools
sudo apt-get -y install python-dev libffi-dev build-essential virtualenvwrapper
sudo -H pip install virtualenv
virtualenv angr
source angr/bin/activate
pip install angr --upgrade


# Enable 32bit binaries on 64bit host
sudo dpkg --add-architecture i386
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386


# Install z3 theorem prover
cd tools
git clone https://github.com/Z3Prover/z3.git && cd z3
python scripts/mk_make.py
cd build
make
sudo make install


# Install binary ninja
mkdir /home/vagrant/tools/binaryninja

# Install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo apt-get update
sudo apt-get -y install libgtk2.0-0
sudo apt-get -y install sublime-text
mkdir -p /home/vagrant/.config/sublime-text-3/Local

# Install chromium
sudo apt-get install -y chromium-browser

# Add ghidra alias
echo "alias ghidra='/home/vagrant/tools/ghidra_9.0/ghidraRun'" >> /home/vagrant/.zshrc
