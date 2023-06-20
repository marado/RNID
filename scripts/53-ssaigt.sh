#!/bin/bash

wget https://ssaigt.dgterritorio.pt/Manuais_SSAIGT/Manual_SSAIGT-REN.pdf -o /dev/null

diff Manual_SSAIGT-REN.pdf scripts/53/Manual_SSAIGT-REN.pdf && (
	echo "ssaigt: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "ssaigt")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
) || echo "ssaigt: incumprimento pode já não existir";

rm Manual_SSAIGT-REN.pdf
