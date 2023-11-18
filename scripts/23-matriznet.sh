#!/bin/bash

if [ "$(wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" http://www.matriznet.dgpc.pt/matriznet/home.aspx -o /dev/null -O -|grep -i x-shockwave-flash -c)" -eq "0" ]; then
	echo "matriznet: incumprimento pode já não existir";
else
	echo "matriznet: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v matriznet|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
