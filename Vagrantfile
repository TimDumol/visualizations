#-*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  module_path = ["puppet/modules", "puppet/vendor_modules"]

  config.vm.box = "ubuntu-precise-32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.share_folder "visualizations", "/home/vagrant/visualizations", '.'
  config.vm.network :hostonly, "172.16.0.51"
  config.vm.forward_port 3000, 3001
  config.vm.forward_port 8080, 9080
  config.vm.provision :puppet, :module_path => module_path do |puppet|
    puppet.manifests_path = "puppet"
    puppet.manifest_file  = "visualizations.pp"
  end
  config.vm.host_name = "visualizations"
end
