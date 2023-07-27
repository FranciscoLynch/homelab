# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
=begin 
      #config.ssh.username = 'root'
      #config.ssh.password = 'vagrant'
      #config.ssh.insert_key = 'true'
      # Esta linea nos permite loguearnos con usuario (vagrant) Password (vagrant) luego hacemos un sudo -i.
      #config.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"
    
      #
      # Descomentar si estamos destras de un proxy
      #
      #if Vagrant.has_plugin?("vagrant-proxyconf")
      #  config.proxy.http     = "http://192.168.150.17:8080"
      #  config.proxy.https    = "http://192.168.150.17:8080"
      #  config.proxy.no_proxy = "localhost,127.0.0.1"
      #end
=end    

    config.vm.define "main-server" do |h|
        h.vm.box = "ubuntu/trusty64"
        h.vm.hostname = "main-server"
        h.vm.network "private_network", ip: "192.168.56.50"
        h.vm.provision "shell", path: "provisioning.sh"
        h.vm.provider "virtualbox" do |vb|
          vb.name = "main-sv-ubuntu-20.04LTS"
          vb.memory = "4192"
          vb.cpus = 2
        end  
    end  
    config.vm.define "server-a" do |h|
        h.vm.box = "ubuntu/trusty64"
        h.vm.hostname = "server-a"
        h.vm.network "private_network", ip: "192.168.56.51"
        h.vm.provision "shell", path: "provisioning.sh"
        h.vm.provider "virtualbox" do |vb|
          vb.name = "server-a-ubuntu-20.04LTS"
	  vb.memory = "512"
          vb.cpus = 1
        end    
    end  
    config.vm.define "server-b" do |h|
        h.vm.box = "ubuntu/trusty64"
        h.vm.hostname = "server-b"
        h.vm.network "private_network", ip: "192.168.56.52"
        h.vm.provision "shell", path: "provisioning.sh"
        h.vm.provider "virtualbox" do |vb|
          vb.name = "server-b-ubuntu-20.04LTS"  
	  vb.memory = "512"
          vb.cpus = 1
        end    
    end  
    config.vm.define "server-c" do |h|
        h.vm.box = "ubuntu/trusty64"
        h.vm.hostname = "server-c"
        h.vm.network "private_network", ip: "192.168.56.53"
        h.vm.provision "shell", path: "provisioning.sh"
        h.vm.provider "virtualbox" do |vb|
          vb.name = "server-c-ubuntu-20.04LTS"
          vb.memory = "512"
          vb.cpus = 1
        end    
    end  
end 


=begin 
    servers=[
        {
            :hostname => "main-server",
            :box => "ubuntu/focal64",
            :ip => "172.16.1.50",
            :ssh_port => '2200'
        },
        {
            :hostname => "server-a",
            :box => "ubuntu/focal64",
            :ip => "172.16.1.51",
            :ssh_port => '2201'
        },
        {
            :hostname => "server-b",
            :box => "ubuntu/focal64",
            :ip => "172.16.1.52",
            :ssh_port => '2202'
        },
        {
            :hostname => "server-c",
            :box => "ubuntu/focal64",
            :ip => "172.16.1.53",
            :ssh_port => '2203'
        }
    ] 

    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.ssh.insert_key = false
            node.vm.network :private_network, ip: machine[:ip]
            node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", 2048]
                vb.customize ["modifyvm", :id, "--cpus", 2]
            end
        end
    end 
=end
