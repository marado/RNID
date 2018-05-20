#!/bin/bash

# http://www.ipma.pt/pt/otempo/prev.localidade/index.jsp - site com flash

if [ "$(wget http://www.ipma.pt/ -o /dev/null -O -|grep -i flashplayer -c)" -eq "0" ]; then
	echo "ipma: incumprimento pode já não existir";
else
	echo "ipma: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v ipma|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
