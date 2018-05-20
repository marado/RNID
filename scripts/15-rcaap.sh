#!/bin/bash
if [ ! "$(wget https://dre.tretas.org/dre/2159741/despacho-14167-2015-de-1-de-dezembro -o /dev/null -O -|grep in_links -c)" -eq "0" ]; then
	echo "rcaap: incumprimento pode já não existir";
else
	echo "rcaap: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v rcaap|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
