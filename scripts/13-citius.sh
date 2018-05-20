#!/bin/bash

# curl -s --head https://citius.tribunaisnet.mj.pt/habilus/Docs/CITIUS_WEB_FIREFOX_MARCO_2017.pdf | head -n 1|grep 200 -c

if [ ! "$(curl -s --head https://citius.tribunaisnet.mj.pt/habilus/Docs/CITIUS_WEB_FIREFOX_MARCO_2017.pdf | head -n 1|grep 200 -c)" -eq "1" ]; then
	echo "citius: incumprimento pode já não existir";
else
	echo "citius: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v citius|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
