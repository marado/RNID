#!/bin/bash

# guia de utilização que prova que ha' uma dependencia no JAVA
wget "https://servicosonline.inpi.pt/registos/guia_certificado.pdf" -o /dev/null
if [ ! "$(diff guia_certificado.pdf scripts/29/guia_certificado.pdf|wc -l)" -eq "0" ]; then
	echo "inpi: incumprimento pode já não existir";
else
	echo "inpi: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v inpi|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm guia_certificado.pdf
