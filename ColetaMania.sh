#!/bin/bash
# MAC Addr como unique id e nome do log que será enviado
addr=$(cat /sys/class/net/*/address | head -n 1) && addr=$(echo $addr | sed 's/://g')
# Processamento de logs do Food
#for i in /opt/videosoft/vs-os-interface/log/vs-fast*.log; do
#sed '/^2/d' $i >>newlog.log 
sed '/^2/d' /opt/videosoft/vs-os-interface/log/vs-fast-food-2.0_2023-08-25.log >>newlog.log 
sed '/^2/d' /opt/videosoft/vs-os-interface/log/vs-fast-food-2.0_2023-08-24.log >>newlog.log 
sed '/^2/d' /opt/videosoft/vs-os-interface/log/vs-fast-food-2.0_2023-08-23.log >>newlog.log 
sed '/^2/d' /opt/videosoft/vs-os-interface/log/vs-fast-food-2.0_2023-08-22.log >>newlog.log 
sed '/^STATUS/d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed '/^RESPONSE/d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed '/^</d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "Nenhum termo encontrado." newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "Partner name" newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "DOCTYPE" newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -E 'useDocumentToFidelity|\"document\"|\"nrCoupon\"|\"score\"|total_value' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -E '\-|total_value' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v '' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed 's/^[ \t]*//' newlog.log | sed -E 'N;/^(.*)\n\1/!P;D' >>newlog3.log && mv newlog3.log newlog.log
awk '!a[$0]++' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -A1 "document\|score" newlog.log >>manialogfood.log
#done
awk '!a[$0]++' manialogfood.log >>$addr-food.log
rm manialogfood.log
# Envio do dos logs processados para o servidor remoto
curl -u 'diego:V$V$V$3363' -T $addr-food.log --insecure sftp://diegovps.vps-kinghost.net/home/diego/manialogs/
rm newlog.log && rm $addr-food.log && exit
