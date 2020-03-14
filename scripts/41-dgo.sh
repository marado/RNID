#!/bin/bash

fails="$(openssl s_client -connect online.dgo.pt:443 < /dev/null 2> /dev/null|grep Protocol|grep -c TLSv1$)"

if [ "$fails" -eq "0" ]; then
	echo "dgo: incumprimento pode já não existir (1)";
else
	echo "dgo: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgo.pt")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
