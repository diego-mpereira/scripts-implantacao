log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsAutoPagSE="2.22.4"
VsFoodLauncher="2.0.0"

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
sudo snap remove brave

log "Parando serviços..."
# Stop all services
killall node

# Backups
log "Criando Backups..."
sudo mkdir -p /opt/videosoft_bkp_log/vs-autopag-se/
sudo mv /opt/videosoft/*tar.gz /opt/videosoft_bkp_log/
sudo mv /opt/videosoft/vs-autopag-se/log/ /opt/videosoft_bkp_log/vs-autopag-se/


# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

# Download packages
log "Download VS Autopag S.E...." 
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Download VS Food Launcher...." 
wget --inet4-only -c https://github.com/wilker-santos/VSDImplantUpdater/raw/main/vs-food-launcher_2.0.0_amd64.deb
log "Download Google Chrome...." 
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install packages
log "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Instalando VS Food Launcher...."
sudo dpkg -i vs-food-launcher_2.0.0_amd64.deb
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb

log "Removendo arquivos temporários...."
# Remove packages
rm *.deb

log "Restaurando Backups...."
# Restaurar Backups
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-07* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-06* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-05* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-04* /opt/videosoft/vs-autopag-se/log/

sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202307* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202306* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202305* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202304* /opt/videosoft/vs-autopag-se/log/dmp/

log "Reiniciando...."
echo "Reiniciando Terminal em 5..."
sleep 1
echo "Reiniciando Terminal em 4..."
sleep 1
echo "Reiniciando Terminal em 3..."
sleep 1
echo "Reiniciando Terminal em 2..."
sleep 1
echo "Reiniciando Terminal em 1..."
sleep 1
echo "Reiniciando Terminal em 0..."
sleep 1
reboot
