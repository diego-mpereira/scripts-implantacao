#!/bin/sh
VsAutoPagSE="2.22.8"
VsOsInterface="2.23.3"
# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y
#Download dos Módulos
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
sudo echo "sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb' >>/tmp/pedidosLog.log" >>/root/moduleupdate.sh
sudo echo "sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb >>/tmp/pedidosLog.log" >>/root/moduleupdate.sh
line="@reboot sleep 10; sh ~/moduleupdate.sh"
$(crontab -u root -l; echo "$line" ) | crontab -u root -
#Docker compose
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose
# Add Docker's official GPG key:
#sudo apt-get update
#sudo apt-get install -y ca-certificates curl gnupg
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get update
#sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

