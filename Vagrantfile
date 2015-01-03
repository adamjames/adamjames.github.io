Vagrant.configure("2") do |config|
  config.vm.box = "chef/debian-7.6"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rysnc__exclude: "_site" 
  config.vm.network "forwarded_port", guest: 4000, host: 8124
  config.vm.provision :shell,
    :path => "provision.sh"

  config.ssh.forward_agent = true
end
