#!/bin/bash
addr=$(cat /sys/class/net/*/address | head -n 1) && addr=$(echo $addr | sed 's/://g')
wget https://raw.githubusercontent.com/diego-mpereira/scripts-implantacao/main/FidelidadeManiaCpfPreco.sh
chmod +x FidelidadeManiaCpfPreco.sh
./FidelidadeManiaCpfPreco.sh /opt/videosoft/vs-os-interface/log/vs-fast*.log
rm FidelidadeManiaCpfPreco.sh
mv manialog.log $addr.log
rm newlog.log
curl -u 'diego:Stonesour159!@' -T $addr.log sftp://diegovps.vps-kinghost.net/home/diego/
