#!/bin/bash
# sudo wget --inet4-only -O- https://script_link.sh | bash

# Versions
VsOsInterface="2.23.3"
VsAutoPagSE="2.22.8"
#VsPrint="2.18.0"
VsFoodLauncher="2.0.0"

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
sudo snap remove brave

echo "Parando serviços..."
# Stop all services
killall node

# Backups
echo "Criando Backups..."
sudo mkdir -p /opt/videosoft_bkp_log/vs-autopag-se/
sudo mkdir -p /opt/videosoft_bkp_log/vs-os-interface/
sudo mkdir -p /opt/videosoft_bkp_log/vs-print/

sudo mv /opt/videosoft/*tar.gz /opt/videosoft_bkp_log/
sudo mv /opt/videosoft/vs-autopag-se/log/ /opt/videosoft_bkp_log/vs-autopag-se/
sudo mv /opt/videosoft/vs-os-interface/log/ /opt/videosoft_bkp_log/vs-os-interface/
sudo mv /opt/videosoft/vs-print/log/ /opt/videosoft_bkp_log/vs-print/

# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

# Download packages
echo "Download VS OS Interface...."
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
echo "Download VS Autopag S.E...." 
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
echo "Download VS Food Launcher...." 
wget --inet4-only -c https://github.com/wilker-santos/VSDImplantUpdater/raw/main/vs-food-launcher_2.0.0_amd64.deb
echo "Download Google Chrome...." 
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install packages
echo "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
echo "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
echo "Instalando VS Food Launcher...."
sudo dpkg -i vs-food-launcher_2.0.0_amd64.deb
echo "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo "Removendo arquivos temporários...."
# Remove packages
rm *.deb

echo "Restaurando Backups...."
# Restaurar Backups
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-07* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-06* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-05* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-04* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202307* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202306* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202305* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202304* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-07* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-06* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-05* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-04* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/_data* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-07* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-06* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-05* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-04* /opt/videosoft/vs-print/log/
echo "Criando init scripts de rotação de tela e wallpaper"
echo "sleep 2" >>/tmp/rotacionar-tela.sh
activeDisplay=$(xrandr | grep " connected " | awk '{ print$1 }')
echo "xrandr --output ${activeDisplay} --mode 1920x1080 --rotate right" >>/tmp/rotacionar-tela.sh
display="monitor${activeDisplay}"
echo "sleep 5 && xfconf-query --channel xfce4-desktop --property /backdrop/screen0/${display}/workspace0/last-image --set /opt/videosoft/scripts/image-install/videosoft-vertical.png" >>/tmp/wallpaper.sh

#####   ...  Array MultiTela  ...  Descomentar apenas se a maquina possuir mais de um monitor#####
#declare -a testeArr=($activeDisplay)
#for key in "${!testeArr[@]}"
#do
#	monitor=${testeArr[$key]}
#	display="monitor${monitor}"
#	echo "xrandr --output ${monitor} --mode 1920x1080 --rotate right" >>/tmp/rotacionar-tela.sh
#	echo "sleep 5 && xfconf-query --channel xfce4-desktop --property /backdrop/screen0/${display}/workspace0/last-image --set /opt/videosoft/scripts/image-install/videosoft-vertical.png" >>/tmp/wallpaper.sh
#done
#####   ...  Array MultiTela  ...  #####

sudo su
#Install Intel Graphics
echo "Instalando Intel Graphics"
mkdir -p /etc/X11/xorg.conf.d
touch 20-intel.conf
echo 'Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection' >>/etc/X11/xorg.conf.d/20-intel.conf
# Incluindo Script Rotação no Init
echo "Instalação Concluida"
echo "**********Inserir scripts wallpaper e resolution**************"
sudo mv /tmp/rotacionar-tela.sh /usr/share/X11/xorg.d/rotacionarTela.conf
sudo mv /tmp/wallpaper.sh /usr/share/X11/xorg.d/wallpaper.conf
sudo chmod +x /usr/share/X11/xorg.d/*.conf
echo "*****************Instalação Concluida*************************"
clear
echo "APT Update && APT Install TeamViewer...."
sleep 1
apt update
echo "Instalar TeamViewer e Reiniciar Terminal em 5..."
sleep 1
echo "Instalar TeamViewer e Reiniciar Terminal em 4..."
sleep 1
echo "Instalar TeamViewer e Reiniciar Terminal em 3..."
sleep 1
echo "Instalar TeamViewer e Reiniciar Terminal em 2..."
echo "Instalar TeamViewer e Reiniciar Terminal em 1..."
sleep 1
echo "Instalar TeamViewer e Reiniciar Terminal em 0..."
sleep 1
apt install teamviewer -y
reboot
