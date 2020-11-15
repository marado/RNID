#!/bin/bash

#	https://www.portalviva.pt/31889.aspx
# https://www.portalviva.pt/pt/homepage/onde-carregar/portal-viva.aspx

wget "https://www.portalviva.pt/pt/homepage/onde-carregar/portal-viva.aspx" -O - -o /dev/null |hxnormalize -x -l 1000|hxselect .contentViva > viva
if [ ! "$(diff viva scripts/20/viva|wc -l)" -eq "0" ]; then
	echo "viva: incumprimento pode já não existir";
else
	echo "viva: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v viva|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm viva
