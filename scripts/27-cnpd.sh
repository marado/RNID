#!/bin/bash

naopassa=$(wget https://www.cnpd.pt/bin/rgpd/rgpd.htm -o /dev/null -O -|hxnormalize -x -l 10000|hxselect li -s'\n'|grep -v xlsx -c);

if [ "$naopassa" -eq "0" ]; then
	echo "CNPD: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "cnpd")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "CNPD: incumprimento potencialmente resolvido";
fi
