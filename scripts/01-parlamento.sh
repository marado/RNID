#!/bin/bash

## Vídeos disponibilizados em WMV
wget 'http://www.parlamento.pt/ActividadeParlamentar/Paginas/DetalheAudiencia.aspx?BID=99371' -o /dev/null -O - | \
	hxnormalize -x -l 10000 2>/dev/null | grep "Links associados" -A 100 | \
	grep "Bottom Fixed Nav" -B 100 | hxnormalize -x -l 10000|hxselect a -s '\n'|hxnormalize|grep href|cut -d\" -f2 > tmp

a=$(diff tmp scripts/01/DetalheAudiencia.aspx?BID=99371 |wc -l)
rm tmp

## resultados:
# Se $a for 0, então o incumprimento mantém-se
if [ ! "$a" -eq "0" ]; then
	echo "parlamento: incumprimento mantém-se, a actualizar README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v www.parlamento.pt|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
else
	echo "parlamento: incumprimento pode já não existir";
fi
