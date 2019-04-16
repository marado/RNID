#!/bin/bash

naopassa=$(curl -A RNID -I http://www.aterratreme.pt/inscreva-se/|grep 200|wc -l);
if [ "$naopassa" -eq "1" ]; then
	echo "terratreme: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "terratreme")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "terratreme: incumprimento resolvido";
fi
