#!/bin/bash

fails="$(wget https://www.siac.vet -o /dev/null -O - | grep "<img" |grep alt=\"\"|wc -l)"

if [ "$fails" -eq "0" ]; then
	echo "siac: incumprimento pode já não existir (1)";
else
	echo "siac: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "siac")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
