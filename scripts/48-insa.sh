#!/bin/bash

wget http://www.insa.min-saude.pt/category/areas-de-atuacao/epidemiologia/covid-19-curva-epidemica-e-parametros-de-transmissibilidade/ -o /dev/null -O -|hxnormalize -x -l 1000|hxselect tr|hxselect a -s"\n" > INSA
if [ ! "$(diff INSA scripts/48/INSA|wc -l)" -eq "0" ]; then
	echo "insa: incumprimento pode já não existir";
else
	echo "insa: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "insa")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm INSA
