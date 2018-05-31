#!/bin/bash

# | https://prevpap.gov.pt | Acessibilidade | [site não cumpre WCAG 2.0 A](https://prevpap.gov.pt) | 2017/07/31 ||

# While we don't have a validator on request, let's find out if a known violation still exists
if [ ! "$(wget https://prevpap.gov.pt -o /dev/null -O - | grep -i "lang"|wc -l)" -eq "0" ]; then
	echo "prevpap: incumprimento pode já não existir";
else
	echo "prevpap: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v prevpap|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
