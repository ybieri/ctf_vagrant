# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.ssh.username = "vagrant"

  config.vm.provision "file", source: "~/ctf/background.jpg", destination: "/home/vagrant/Pictures/background.jpg"
  config.vm.synced_folder "~/ctf/shared", "/home/vagrant/shared"
  config.vm.provision :shell, :path => "vagrant_setup.sh", :privileged => false
  config.vm.provision "file", source: "~/ctf/binaryninja", destination: "/home/vagrant/tools/binaryninja"
  config.vm.provision "file", source: "~/ctf/License.sublime_license", destination: "/home/vagrant/.config/sublime-text-3/Local/License.sublime_license"
  config.vm.provision "file", source: "~/ctf/ghidra_9.0", destination: "/home/vagrant/tools/ghidra_9.0"

  name = "ctf-ubuntu"
  memory = "4096"

  config.vm.define name

  config.vm.network "private_network", ip: "10.10.10.10"



  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    vb.name = name
    # Customize the amount of memory on the VM:
    vb.memory = memory
    vb.customize ["modifyvm", :id, "--vram", "64"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

end
