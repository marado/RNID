#!/bin/bash

# XXX: pode haver outro incumprimento com o certificado HTTPS, verificar

# https://www.iefp.pt/ - não cumpre WCAG 2.0 AA
if [ "$(wget --no-check-certificate https://servicos.min-saude.pt/utente/ -o /dev/null -O - | grep "<img" |grep -v alt|wc -l)" -eq "0" ]; then
	echo "servicos min-saude: incumprimento pode já não existir";
else
	echo "servicos min-saude: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v servicos.min-saude|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
