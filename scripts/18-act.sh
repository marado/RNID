#!/bin/bash

# While we don't have a validator on request, let's find out if a known violation still exists
if [ "$(wget -t 1 http://www.act.gov.pt/ --user-agent="Mozilla/5.0 Gecko/20100101 Firefox/21.0" -o /dev/null -O - | grep -i "<img" |grep -v -i alt|wc -l)" -eq "0" ]; then
	echo "act: incumprimento pode já não existir";
else
	echo "act: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v act.gov|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
