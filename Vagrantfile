# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :


current_dir    = File.dirname(File.expand_path(__FILE__))

# master node
master_machine = {
  :hostname => "k8s-master",
  :ip => "10.10.10.20",
  :box => "ubuntu/jammy64",
  :ram => 2048,
  :cpu => 1,
  :autostart => true
}

# workers
machines=[
  {
    :hostname => "k8s-worker001",
    :ip => "10.10.10.21",
    :box => "ubuntu/jammy64",
    :ram => 2048,
    :cpu => 1,
    :autostart => false
  },
  {
    :hostname => "k8s-worker002",
    :ip => "10.10.10.22",
    :box => "ubuntu/jammy64",
    :ram => 2048,
    :cpu => 1,
    :autostart => false
  }
]

Vagrant.configure(2) do |config|
  
  # create hosts config for /etc/hosts
  hosts=""
  hosts=hosts+"\n"+ master_machine[:ip] + "\t" + master_machine[:hostname]
  machines.each do |host|
    hosts=hosts+"\n"+ host[:ip] + "\t" + host[:hostname]
  end

  # Master machone
  config.vm.define master_machine[:hostname], autostart: master_machine[:autostart] do |mnode|
    mnode.vm.box = "generic/ubuntu2204"
    #mnode.vm.box = master_machine[:box]
    mnode.vm.hostname = master_machine[:hostname]
    mnode.vm.network "private_network", ip: master_machine[:ip]
    mnode.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", master_machine[:ram]]
      #config.vbguest.auto_update = false
    end
    config.vm.synced_folder "./common/shared/", "/tmp/shared", create: true,
      owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]
    #increase timeout
    mnode.vm.boot_timeout = 2000

    # config.vm.post_up_message = ""
  
    # https://github.com/agiledivider/vagrant-hostsupdater
    if Vagrant.has_plugin?("vagrant-hostsupdater")  
      config.hostsupdater.aliases = [master_machine[:hostname]]
    end

    mnode.vm.provision :shell, inline: "sudo hostnamectl set-hostname " + master_machine[:hostname]
    mnode.vm.provision :shell, inline: "sudo cat > /etc/hosts<< EOF\n" + hosts + "\nEOF"
    mnode.vm.provision :shell, inline: "cat /etc/hosts"

    mnode.vm.provision :shell, path: "common/scripts/k8s-master1.sh", 
      :env => {
        "SERVER_NAME" => master_machine[:hostname],
        "IP_ADDR"     => master_machine[:ip]
      }
  end

  machines.each do |machine|
    config.vm.define machine[:hostname], autostart: machine[:autostart] do |node|
      #puts "machine: " + machine[:hostname] + " machine0:" + machines[0][:hostname] + " "
      node.vm.box = "generic/ubuntu2204"
      #node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
        #config.vbguest.auto_update = false
      end
      node.vm.synced_folder "./common/shared/", "/tmp/shared", create: true,
        owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]
      #increase timeout
      node.vm.boot_timeout = 2000

      # config.vm.post_up_message = ""
    
      # https://github.com/agiledivider/vagrant-hostsupdater
      if Vagrant.has_plugin?("vagrant-hostsupdater")  
        config.hostsupdater.aliases = [machine[:hostname]]
      end
    
      node.vm.provision :shell, inline: "sudo hostnamectl set-hostname " + machine[:hostname]
      node.vm.provision :shell, inline: "sudo cat > /etc/hosts<< EOF\n" + hosts + "\nEOF"
      node.vm.provision :shell, inline: "cat /etc/hosts"

        #puts " ⚒ 🛠 🔨 running worker scripts"
        node.vm.provision :shell, path: "common/scripts/k8s-worker.sh", 
          :env => {
            "SERVER_NAME" => machine[:hostname],
            "IP_ADDR"     => machine[:ip]
          }
    end
  end
end