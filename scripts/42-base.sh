#!/bin/bash

fails="$(wget https://www.base.gov.pt/base2-backoffice/images/fundo_base.png -o - -O /dev/null|grep -c ^Unable)"

if [ "$fails" -eq "0" ]; then
	echo "base: incumprimento pode já não existir (1)";
else
	echo "base: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "base")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
