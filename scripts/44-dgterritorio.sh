#!/bin/bash

wget http://tcp.dgterritorio.gov.pt/procurar -o /dev/null -O -| hxnormalize -x -l 10000|hxselect .feed-icon > xls
if [ ! "$(diff xls scripts/44/xls|wc -l)" -eq "0" ]; then
	echo "dgterritorio: incumprimento pode já não existir";
else
	echo "dgterritorio: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgterritorio")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm xls
