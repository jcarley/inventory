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

$expose_docker_tcp="2375"
$vm_private_ip="192.168.33.10"

$upgrade_docker = <<-SCRIPT
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' | tee /etc/apt/sources.list.d/docker.list
  apt-get update
  apt-get purge lxc-docker* -y
  apt-get install docker-engine -y
SCRIPT

$docker_config = <<-SCRIPT
  echo 'DOCKER_OPTS="-H tcp://#{$vm_private_ip}:#{$expose_docker_tcp}"' | tee /etc/default/docker
  restart docker
SCRIPT

$usage = <<-SCRIPT
  echo "Export the following to connect to the vm remotely."
  echo export DOCKER_HOST='tcp://#{$vm_private_ip}:#{$expose_docker_tcp}'
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :vmware_fusion do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
  end

  config.vm.provider :virtualbox do |v|
    config.vbguest.auto_reboot = true
    v.memory = 2048
    v.cpus = 4
    v.customize ["modifyvm", :id,
                 "--nictype1", "Am79C973",
                 "--nictype2", "Am79C973"]
  end

  config.vm.box = "boxcutter/ubuntu1404-docker"

  config.vm.network :private_network, ip: $vm_private_ip

  # Enable port forwarding of Docker TCP socket
  # Set to the TCP port you want exposed on the *host* machine, default is 2375
  # If 2375 is used, Vagrant will auto-increment (e.g. in the case of $num_instances > 1)
  # You can then use the docker tool locally by setting the following env var:
  #   export DOCKER_HOST='tcp://192.168.33.10:2375'
  if $expose_docker_tcp
    config.vm.network :forwarded_port, guest: $expose_docker_tcp, host: $expose_docker_tcp, auto_correct: true
  end

  config.vm.network :forwarded_port, guest: 9000, host: 9000, :auto => true
  config.vm.network :forwarded_port, guest: 9292, host: 9292, :auto => true
  config.vm.network :forwarded_port, guest: 80, host: 80, :auto => true
  config.vm.network :forwarded_port, guest: 8080, host: 8080, :auto => true

  # config.vm.provision "shell", path: "scripts/runner.sh"
  config.vm.provision "shell", inline: $upgrade_docker, run: "once", :privileged => true
  config.vm.provision "shell", inline: $docker_config, run: "once", :privileged => true
  config.vm.provision "shell", inline: $usage, run: "always"

  ## Share the default `vagrant` folder via NFS with your own options
  config.vm.synced_folder ".", "/vagrant", type: :nfs
  config.bindfs.bind_folder "/vagrant", "/vagrant"

  config.vm.synced_folder ".", "/home/vagrant/apps/inventory", :nfs => true
  config.bindfs.bind_folder "/home/vagrant/apps/inventory", "/home/vagrant/apps/inventory"
end
