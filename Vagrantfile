# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :vmware_fusion do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
  end

  config.vm.provider :virtualbox do |v|
    # config.vbguest.auto_reboot = true
    v.memory = 2048
    v.cpus = 4
    v.customize ["modifyvm", :id,
                 "--nictype1", "Am79C973",
                 "--nictype2", "Am79C973"]
  end

  # config.vm.box = "jcarley/ubuntu1404-docker-puppet"
  # config.vm.box = "ubuntu/trusty64"
  # config.vm.box = "chef/ubuntu-14.04"
  config.vm.box = "jcarley/ubuntu1404"

  # config.vm.provision "shell", path: "scripts/base.sh"
  # config.vm.provision "shell", path: "scripts/database.sh"
  # config.vm.provision "shell", path: "scripts/ruby.sh"
  config.vm.provision "shell", path: "scripts/runner.sh"

  config.vm.network :private_network, ip: "33.33.33.4"
  config.vm.network :forwarded_port, guest: 9292, host: 9292, :auto => true
  config.vm.network :forwarded_port, guest: 80, host: 80, :auto => true
  config.vm.network :forwarded_port, guest: 8080, host: 8080, :auto => true

  config.vm.synced_folder ".", "/home/vagrant/apps/inventory", :nfs => true
end
