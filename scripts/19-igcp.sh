#!/bin/bash

# | https://www.igcp.pt/ | XLS | [conteúdo em XLS](https://www.igcp.pt/pt/gca/?id=80) | 2018/03/29 ||

wget "https://www.igcp.pt/pt/gca/?id=80" -O - -o /dev/null |hxnormalize -x -l 1000|hxselect .texto|hxselect table > igcp
if [ ! "$(diff igcp scripts/19/igcp-table|wc -l)" -eq "0" ]; then
	echo "igcp: incumprimento pode já não existir";
else
	echo "igcp: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v igcp|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm igcp
