#!/bin/bash

fails="$(wget http://www.estradas.pt/js/mapservices/camaras.js -o /dev/null -O - | grep -c swf)"

if [ "$fails" -eq "0" ]; then
	echo "estradas: incumprimento pode já não existir (1)";
else
	echo "estradas: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "estradas")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
