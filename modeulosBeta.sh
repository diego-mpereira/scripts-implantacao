#!/bin/sh
VsAutoPagSE="2.22.8"
VsOsInterface="2.23.3"
#Download dos Módulos
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
sudo echo sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
