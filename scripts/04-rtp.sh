#!/bin/bash

# https://www.iefp.pt/ - não cumpre WCAG 2.0 AA
# RTP - flash e WMV

echo "Este script deve ser modificado com os novos links sobre estes incumprimentos (estão no README.md)."

# flash=$(wget http://media.rtp.pt/empresa/utilizacao/termos-e-condicoes/ --user-agent="Mozilla/5.0 Gecko/20100101 Firefox/21.0" -o /dev/null -O -|grep -i flash|wc -l)
# wmv=$(wget http://media.rtp.pt/empresa/utilizacao/termos-e-condicoes/ --user-agent="Mozilla/5.0 Gecko/20100101 Firefox/21.0" -o /dev/null -O -|grep -i windows|wc -l)
# 
# mudancas=0;
# if [ "$flash" -eq "0" ]; then
# 	echo "RTP: Flash: incumprimento pode já não existir";
# 	mudancas=1;
# fi
# if [ "$wmv" -eq "0" ]; then
# 	echo "RTP: WMV: incumprimento pode já não existir";
# 	mudancas=1;
# fi
# 
# ## 20/05/2018: - several images without an alt attribute:
# if [ "$mudancas" -eq "0" ]; then
# 	echo "RTP: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
# 	while IFS='' read -r line || [[ -n "$line" ]]; do
# 		test $(echo "$line"|grep -v rtp|wc -l) -eq "1" \
# 			&& echo "$line" \
# 			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
# 	done < README.md > new
# 	mv new README.md
# fi
