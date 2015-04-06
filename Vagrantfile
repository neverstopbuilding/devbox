# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/trusty64"
  config.vm.hostname = "talon"

  config.vm.provider :virtualbox do |vb|
    # This allows symlinks to be created within the /vagrant root directory,
    # which is something librarian-puppet needs to be able to do. This might
    # be enabled by default depending on what version of VirtualBox is used.
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.memory = 2048
    vb.cpus = 2
  end

  # Typical Rails server
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Typical Middleman server
  config.vm.network "forwarded_port", guest: 4567, host: 4567

  # Loosen permissions on shared folder items
  config.vm.synced_folder './', '/vagrant', :mount_options => ["dmode=777","fmode=766"], create: true

  # SSH Configuration
  config.ssh.forward_agent = true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. This has to be done before the puppet provisioning so that
  # the modules are available when puppet tries to parse its manifests.
  config.vm.provision :shell, :path => "shell/librarian-puppet.sh"

  # Now run the puppet provisioner. Note that the modules directory is entirely
  # managed by librarian-puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
  end

end
