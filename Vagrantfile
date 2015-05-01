Vagrant.configure(2) do |config|
  config.vm.box = "centos6-64"

   config.vm.synced_folder "../sharedhost3", "/vagrant_data"

   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "2048"
   end
  #
  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 22001, host: 22001
  config.vm.provision "shell", path: "yum-update.sh" 
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
	# Custom facts provided to Puppet
    puppet.facter = {
      # Tells Puppet that we're running in Vagrant
      "is_vagrant" => true,
    }
  end
  
end
