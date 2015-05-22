# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Automatically upgrade virtual box guest additions if vbguest plugin is installed or not
VBGUEST_AUTO = ENV["V_VBGUEST_AUTO"] || "1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Define name
  config.vm.define "pthreads01" do |pthreads01|
    pthreads01.vm.network "private_network", ip: "192.168.3.3"
    pthreads01.vm.provider "vmware_fusion" do |vmware|
      vmware.vmx["memsize"] = "1024"
      vmware.customize ["modifyvm", :id, "--cpus", "1"]
    end
    pthreads01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 1024
      virtualbox.cpus = 1
    end
    pthreads01.vm.box = "ubuntu/trusty64"
    pthreads01.vm.host_name = "pthreads01.vm"
    pthreads01.vm.provision "shell", path: "shell/bootstrap_ubuntu.sh"
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    unless VBGUEST_AUTO == "1"
      puts "Skipping vbguest auto update"
      config.vbguest.auto_update = false
    end
  else
    puts "Installing vagrant-vbguest plugin is highly recommended!"
  end
end
