#!/bin/bash

fails="$(curl -s --head  http://www2.sg.pcm.gov.pt/GEUPF/Login.aspx|head -n 1|grep -c 200)"

if [ "$fails" -eq "0" ]; then
	echo "pcm: incumprimento pode já não existir (1)";
else
	echo "pcm: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "pcm")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
