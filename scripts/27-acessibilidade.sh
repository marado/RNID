#!/bin/bash

naopassa=$(wget "http://www.acessibilidade.gov.pt/accessmonitor/wcag20/?sid=3268" -o /dev/null -O -|grep -c "Não Passa nível A");
if [ "$naopassa" -eq "1" ]; then
	echo "acessibilidade: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "acessibilidade.gov")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
