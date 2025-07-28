#!/bin/bash

wget --no-check-certificate https://www.dgeg.gov.pt/pt/estatistica/energia/petroleo-e-derivados/vendas-mensais/ -o /dev/null -O - | \
	hxnormalize -x -l 1000 | hxselect div .tema-content > dgeg

# TODO: testar-lhe também este incumprimento: https://whatsmychaincert.com/?www.dgeg.gov.pt

if [ ! "$(diff dgeg scripts/51/dgeg|wc -l)" -eq "0" ]; then
	echo "dgeg: um incumprimento pode já não existir (e outro não está a ser testado!)";
else
	echo "dgeg: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgeg")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm dgeg
