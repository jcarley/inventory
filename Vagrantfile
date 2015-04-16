# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

required_plugins = %w(vagrant-share vagrant-vbguest vagrant-bindfs)

required_plugins.each do |plugin|
  need_restart = false
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    need_restart = true
  end
  exec "vagrant #{ARGV.join(' ')}" if need_restart
end

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

  config.vm.box = "jcarley/ubuntu1404"

  config.vm.provision "shell", path: "scripts/runner.sh"

  config.vm.network :private_network, ip: "33.33.33.4"
  config.vm.network :forwarded_port, guest: 9000, host: 9000, :auto => true
  config.vm.network :forwarded_port, guest: 9292, host: 9292, :auto => true
  config.vm.network :forwarded_port, guest: 80, host: 80, :auto => true
  config.vm.network :forwarded_port, guest: 8080, host: 8080, :auto => true

  ## Share the default `vagrant` folder via NFS with your own options
  config.vm.synced_folder ".", "/vagrant", type: :nfs
  config.bindfs.bind_folder "/vagrant", "/vagrant"

  config.vm.synced_folder ".", "/home/vagrant/apps/inventory", :nfs => true
  config.bindfs.bind_folder "/home/vagrant/apps/inventory", "/home/vagrant/apps/inventory"
end
