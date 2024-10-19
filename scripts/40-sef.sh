#!/bin/bash

# TODO: check if the certificate issue is already fixed! Does wget work without --no-check-certificate ?

wget --no-check-certificate "https://www.sef.pt/pt/pages/conteudo-detalhe.aspx?nID=73" -o /dev/null -O -|grep DOC > SEF
if [ ! "$(diff SEF scripts/40/SEF|wc -l)" -eq "0" ]; then
	echo "SEF: incumprimento pode já não existir";
else
	echo "SEF: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "sef.pt")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm SEF
