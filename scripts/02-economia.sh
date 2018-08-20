#!/bin/bash

# [página com formulários Microsoft Word]
wget "http://www.dgae.gov.pt/pagina.aspx?f=1&lws=1&mcna=0&lnc=AAAAAAAAAAAAAAAAAAAAAAAA&parceiroid=0&codigoms=0&codigono=80958335AAAAAAAAAAAAAAAA" -o /dev/null -O - | \
	grep mlkFrame > teste;
diferencas=$(diff teste scripts/02/pagina.aspx|wc -l)
if [ ! "$diferencas" -eq "0" ]; then
	echo "economia: incumprimento pode já não existir";
else
	echo "economia: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v min-economia|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm teste
