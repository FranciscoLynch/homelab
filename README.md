# Home Lab 

Local environment to practice, make projects and tests with new technologies. 

It's given a very little app on Python to test the deploy with Docker Compose and Docker Swarm. 

#### Tech Stack 
- Vagrant 
- Ansible
- Python
- Docker, Compose and Swarm

## 1. Installation
- Vagrant: https://www.vagrantup.com/docs/installation
- Oracle Virtualbox: https://www.vagrantup.com/docs/providers/virtualbox

### Clone the repository

```
git clone https://github.com/FranciscoLynch/homelab.git
```

### Enter the Lab

**Check if the configuration in the Vagrantfile fits with your hardware, especially CPU and Memory**

#### Usage/Example

```
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
```

Once it's ready (inside the /homelab)

```
vagrant up 
vagrant ssh (name of the vm)
```

In case of being necessary >> *Password: vagrant*

In case the main Vagrantfile throw some error, try using the one in the vagrantfile-b folder. 
Is that the case, you have to comment the first seven lines in the /Ansible/myhosts and uncomment the next ones.


#### Vagrant Cheat Sheet

https://gist.github.com/devopsjourney1/7a5f21fddef564eb8c68dd7901d0f6be


Once your are inside of the main-server (or *control* in case of using the second Vagrantfile) what you're going to do is stablish the communication between the servers.

```
ping server-a (or node1) # this should give you a temporary failure in name resolution
cd /vagrant
sudo cp hosts /etc/hosts
ping server-a (or node1) # this should show you the bytes of data
```

## 2. Servers configuration with Ansible 

### Install Ansible on control station (main-server)
```
sudo apt-get install ansible -y
```

### Make hosts SSH accessible
```
ssh-keygen
ssh-copy-id server-a && ssh-copy-id server-b && ssh-copy-id server-c
```

#### Test ansible

If you are using the main Vagrantfile won't be problem, but if you're using the vagrantfile-b, you will have to create the file *myhosts* (the one inside /Ansible) inside of the /vagrant/ on the vm. Check it.

```
ansible nodes -i myhosts -a hostname
```
#### Install Python 
```
ansible nodes -i myhosts -a 'sudo apt-get -y install python-simplejson'
```

#### Run the playbook to install docker
```
ansible-playbook -i myhosts -K playbook1.yml
```

## 3. Using Docker  


### Test Docker
Log into server-a and test to make sure docker is working.

```
docker run hello-world
```

### Test docker compose app
```
docker compose up -d
```

### Troubleshooting
Sometimes if you made a mistake in one of the files, you made have to re-do the image build with docker-compose build
```
docker compose build
```

### Testing
```
curl server-a:5000
```

## 4. Using Docker Swarm



### Clone the ansible project
```
git clone https://github.com/devopsjourney1/ansible-swarm-playbook
```
*Note I had to change eth0 to eth1 in this, since ip address didn't match. 


### Verify docker swarm is setup.
```
sudo docker node ls
```

```
sudo docker stack ls
sudo docker ps
sudo docker-compose down
```
### Migrate your app

* Copy over dockerfiles folder inside of the Docker one to a new app folder

```
docker build -t devopsjourney1/myflaskimg:1 .
```
*modify docker-compose file to use image instead of build*

```
docker stack deploy --compose-file docker-compose.yml myapp
```

```
docker stack ls
docker stack services myapp
docker service logs -f myapp_web
docker service ps myapp_web
docker service update --force myapp_web
docker service rm disml3ux1mye
docker stack deploy --compose-file docker-compose.yml myapp
curl server-a:5000
docker service scale myapp_web=3
```

*change image to devopsjourney1/myflaskimg:1*

```
docker service rm pky4n44z0790
docker stack deploy --compose-file docker-compose.yml myapp
docker service scale myapp_web=5
docker service ls
docker service ps myapp_web
```

```
docker stack rm myapp
docker network create --driver overlay --attachable --subnet 192.168.35.0/24 myoverlay
docker network ls
``` 

```
docker stack deploy --compose-file docker-compose.yml myapp
docker service inspect --format '{{json .Endpoint.VirtualIPs}}' myapp_web | jq '.'
```

```
docker container run --rm --network myapp_myoverlay tutum/dnsutils ping 10.0.12.6
```


**Credits to this video: https://www.youtube.com/watch?v=YuZ002YrvUA**
