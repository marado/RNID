#!/bin/bash

if [ ! "$(wget https://www.min-saude.pt/ -o -|grep cert|wc -l)" -eq "1" ]; then
	echo "certificado min-saude: incumprimento pode já não existir";
else
	echo "certificado min-saude: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v www.min-saude|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
