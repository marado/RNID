#!/bin/bash

if [ "$(wget http://www.museudoazulejo.gov.pt/ -o /dev/null -O -|grep -i x-shockwave-flash -c)" -eq "0" ]; then
	echo "azulejo: incumprimento pode já não existir";
else
	echo "azulejo: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v azulejo|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
