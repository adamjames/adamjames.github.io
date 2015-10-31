Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rysnc__exclude: "_site" 
  config.vm.network "forwarded_port", guest: 4000, host: 8124
  config.ssh.forward_agent = true

  # Technique shamelessly pinched from https://github.com/neurodesign/vagrant-jekyll/
  # because it means I can get rid of that crappy provisioning script I threw together.

  # Some minor adjustments to more closely match the official instructions:
  # 1. Make use of Bundler and a Gemfile specifying the github-pages gem (requiring additional dependencies).
  # 2. Execute it in the recommended way (bundle exec jekyll serve blah blah blah).
  config.vm.provision :shell,
    :privileged => true,
    :inline => "apt-get -y install screen ruby2.1 rubygems ruby2.1-dev nodejs && gem install bundler"

  config.vm.provision :shell,
    :run => "always",
    :privileged => false,
    :inline => "cd /vagrant && bundle install && cd /vagrant && screen -S jekyll -d -m bundle exec jekyll serve -P 4000 --watch --force_polling"
end
