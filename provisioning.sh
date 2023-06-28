#!/usr/bin/bash

# Habilita SSH remoto
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PrintMotd yes/PrintMotd no/g' /etc/ssh/sshd_config
sed -i 's/PrintLastLog yes/PrintLastLog no/g' /etc/ssh/sshd_config
systemctl restart sshd

# Detiene Firewall
systemctl disable ufw --now

# Actualiza e instala paqueteria adisional
apt update -y
apt upgrade -y
apt install -y git jq curl wget net-tools sysstat tree stress lsb-core lsof
# apt install -y policycoreutils selinux-utils selinux-basics
# Desactiva SELinux
# sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

timedatectl set-timezone America/Argentina/Buenos Aires

# Personalizacion del entorno
cp /vagrant/00-custom /etc/update-motd.d/00-custom
chmod 755 /etc/update-motd.d/00-custom.sh
sed -i 's/^alias l=/#alias l=/g' /root/.bashrc
grep -qxF "alias l='ls -la'" /etc/profile || echo "alias l='ls -la'" >>/etc/profile

# Fresh reboot
reboot
