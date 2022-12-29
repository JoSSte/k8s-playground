# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
machines = YAML.load_file("#{current_dir}/common/config.yaml")
puts machines

Vagrant.configure(2) do |config|
  machines.each do |machine|
    puts machine[0]
    config.vm.box = "ubuntu/jammy64"
    config.vm.define machine[0]
  
    config.vm.network 'private_network', ip: machine[1]
  
    #increase timeout
    config.vm.boot_timeout = 2000
    
    # configure virtualbox settings
    # https://www.vagrantup.com/docs/providers/virtualbox/configuration
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      
    end
  
    #config.vbguest.auto_update = false
  
    # config.vm.post_up_message = ""
  
    # https://github.com/agiledivider/vagrant-hostsupdater
    if Vagrant.has_plugin?("vagrant-hostsupdater")  
      config.hostsupdater.aliases = [machine[0]]
    end
  
    if Vagrant.has_plugin?("vagrant-cachier")
      # Configure cached packages to be shared between instances of the same base box.
      # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
      config.cache.scope = :box
  
      # OPTIONAL: If you are using VirtualBox, you might want to use that to enable
      # NFS for shared folders. This is also very useful for vagrant-libvirt if you
      # want bi-directional sync
      config.cache.synced_folder_opts = {
        type: :nfs,
        # The nolock option can be useful for an NFSv3 client that wants to avoid the
        # NLM sideband protocol. Without this option, apt-get might hang if it tries
        # to lock files needed for /var/cache/* operations. All of this can be avoided
        # by using NFSv4 everywhere. Please note that the tcp option is not the default.
        mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
      }
      # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
    end
    
    # configure k8s basic setup
    config.vm.provision :shell, path: "common/scripts/k8s-basic.sh", 
      :env => {
        "SERVER_NAME" => machine[0],
        "IP_ADDR"     => machine[1]
      }
      config.vm.provision :shell, inline: "ip addr"
  #
  #  # configure k8s master setup
  #  config.vm.provision :shell, path: "common/scripts/k8s-master.sh", 
  #    :env => {
  #      "SERVER_NAME" => machine[0],
  #      "IP_ADDR"     => machine[1]
  #    }
  #    config.vm.provision :shell, inline: "ip addr"
    end
end