#!/bin/bash
# MAC Addr como unique id e nome do log que será enviado
addr=$(cat /sys/class/net/*/address | head -n 1) && addr=$(echo $addr | sed 's/://g')
# Processamento de logs do Food
for i in /opt/videosoft/vs-os-interface/log/vs-fast*.log; do
sed '/^2/d' $i >>newlog.log 
grep -v 'Partner name|\DOCTYPE|\Nenhum termo encontrado.|\\": 0,\|\STATUS|\RESPONSE|\<' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -E 'useDocumentToFidelity|\"document\"|\"nrCoupon\"|\"score\"|total_value\-' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -A1 "document\|score" newlog.log >>manialogfood.log
done
# Processamento de logs do Self
for i in /opt/videosoft/vs-os-interface/log/vs-self*.log; do
grep -E 'total_conta' $i >>manialogself.log 
done
mv manialogfod.log $addr-food.log
mv manialogself.log $addr-self.log
rm newlog.log
# Envio do dos logs processados para o servidor remoto
curl -u 'diego:Stonesour159!@' -T $addr-food.log --insecure sftp://diegovps.vps-kinghost.net/home/diego/manialogs/
curl -u 'diego:Stonesour159!@' -T $addr-self.log --insecure sftp://diegovps.vps-kinghost.net/home/diego/manialogs/
