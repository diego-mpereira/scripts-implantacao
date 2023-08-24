#!/bin/bash
for i in /opt/videosoft/vs-os-interface/log/vs-fast*.log; do
sed '/^2/d' $i >>newlog.log 
sed '/^STATUS/d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed '/^RESPONSE/d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed '/^</d' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "Nenhum termo encontrado." newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "Partner name" newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v "DOCTYPE" newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -E 'useDocumentToFidelity|\"document\"|\"nrCoupon\"|\"score\"|total_value' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -E '\-|total_value' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -v '\": 0,' newlog.log >>newlog3.log && mv newlog3.log newlog.log
sed 's/^[ \t]*//' newlog.log | sed -E 'N;/^(.*)\n\1/!P;D' >>newlog3.log && mv newlog3.log newlog.log
awk '!a[$0]++' newlog.log >>newlog3.log && mv newlog3.log newlog.log
grep -A1 "document\|score" newlog.log >>newlog3.log && mv newlog3.log manialog.log
done
