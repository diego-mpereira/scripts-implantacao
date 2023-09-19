#!/bin/sh
VsAutoPagSE="2.22.8"
VsOsInterface="2.23.3"
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
sudo rm /var/lib/dpkg/lock-frontend && sudo rm /var/lib/dpkg/lock
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
wget https://raw.githubusercontent.com/diego-mpereira/scripts-implantacao/main/docker.sh && sudo sh docker.sh
