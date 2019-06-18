#!/bin/bash

wget https://www.portugal2020.pt/content/lista-de-operacoes-aprovadas -o /dev/null -O -|hxnormalize -x -l 10000|hxselect .even -c |hxselect .even -c > even
if [ ! "$(diff even scripts/30/even|wc -l)" -eq "0" ]; then
	echo "2020: incumprimento pode já não existir";
else
	echo "2020: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "2020")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm even
