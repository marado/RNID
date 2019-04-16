#!/bin/bash

naopassa=$(wget http://azores.gov.pt -o /dev/null -O -|grep -c swf);

if [ "$naopassa" -eq "1" ]; then
	echo "azores: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "azores")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "azores: incumprimento resolvido";
fi
