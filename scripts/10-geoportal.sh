#!/bin/bash

# http://geoportal.lneg.pt/index.php - site com flash

if [ "$(wget http://geoportal.lneg.pt/geoportal/ -o /dev/null -O -|grep -i flashplayer -c)" -eq "0" ]; then
	echo "geoportal: incumprimento pode já não existir";
else
	echo "geoportal: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v geoportal|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
