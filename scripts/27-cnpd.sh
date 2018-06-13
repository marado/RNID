#!/bin/bash

wget "https://www.cnpd.pt/bin/notifica_rgpd/epd_dpo.htm" -o /dev/null
if [ ! "$(diff epd_dpo.htm scripts/27/epd_dpo.htm|wc -l)" -eq "0" ]; then
	echo "CNPD: incumprimento pode já não existir";
else
	echo "CNPD: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v cnpd|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm epd_dpo.htm
