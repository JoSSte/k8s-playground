# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :


current_dir    = File.dirname(File.expand_path(__FILE__))
machines=[
  {
    :hostname => "k8s-master",
    :ip => "10.10.10.20",
    :box => "JoSSte/k8sBasic",
    :ram => 2048,
    :cpu => 1
  },
  {
    :hostname => "k8s-worker001",
    :ip => "10.10.10.21",
    :box => "JoSSte/k8sBasic",
    :ram => 2048,
    :cpu => 1
  }
]

Vagrant.configure(2) do |config|
  machines.each do |machine|
    config.vm.define machine[:hostname] do |node|
    
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
        #config.vbguest.auto_update = false
      end
    
      #increase timeout
      node.vm.boot_timeout = 2000

      # config.vm.post_up_message = ""
    
      # https://github.com/agiledivider/vagrant-hostsupdater
      if Vagrant.has_plugin?("vagrant-hostsupdater")  
        config.hostsupdater.aliases = [machine[:hostname]]
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
      node.vm.provision :shell, inline: "sudo hostnamectl set-hostname " + machine[:hostname]

    #
    #  # configure k8s master setup
    #  config.vm.provision :shell, path: "common/scripts/k8s-master.sh", 
    #    :env => {
    #      "SERVER_NAME" => machine[0],
    #      "IP_ADDR"     => machine[1]
    #    }
    #    
    end
  end
end