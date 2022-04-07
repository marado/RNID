#!/bin/bash

wget https://www.dgeg.gov.pt/pt/estatistica/energia/petroleo-e-derivados/vendas-mensais/ -o /dev/null -O - | \
	hxnormalize -x -l 1000 | hxselect div .tema-content > dgeg

if [ ! "$(diff dgeg scripts/51/dgeg|wc -l)" -eq "0" ]; then
	echo "dgeg: incumprimento pode já não existir";
else
	echo "dgeg: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgeg")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm dgeg
