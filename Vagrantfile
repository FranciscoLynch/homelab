Vagrant.configure("2") do |config|
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
