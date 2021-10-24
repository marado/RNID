#!/bin/bash

# While we don't have a validator on request, let's find out if a known violation still exists
content=$(wget -t 1 --no-check-certificate http://www.act.gov.pt/ --user-agent="Mozilla/5.0 Gecko/20100101 Firefox/21.0" -o /dev/null -O -);
if [ "$( echo "$content" | wc -l )" -eq "0" ]; then
	echo "act: página vazia! Pode ser problema no site, ou no script.";
	echo "DEBUG: ";
	wget -t 1 --no-check-certificate http://www.act.gov.pt/ --user-agent="Mozilla/5.0   Gecko/20100101 Firefox/21.0";
	rm index.html;
fi

if [ "$( echo "$content" | grep -i "<img" |grep -v -i alt|wc -l)" -eq "0" ]; then
	echo "act: incumprimento pode já não existir";
	# TODO: verificar também se o problema com o certiicado ja' esta' resolvido
else
	echo "act: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v act.gov|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
