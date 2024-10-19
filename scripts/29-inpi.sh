#!/bin/bash

# guia de utilização que prova que ha' uma dependencia no JAVA
curl -s --head https://servicosonline.inpi.justica.gov.pt/registos/guia_certificado.pdf | head -n 1 | egrep "HTTP/1.[01] [23]..|HTTP/2 [23].." > /dev/null ; naodisponivel=$?
wget "https://servicosonline.inpi.justica.gov.pt/registos/guia_certificado.pdf" -o /dev/null
if [ ! "$naodisponivel" -eq "0" ]; then
	echo "inpi: incumprimento pode já não existir (1)";
elif [ ! "$(diff guia_certificado.pdf scripts/29/guia_certificado.pdf|wc -l)" -eq "0" ]; then
	echo "inpi: incumprimento pode já não existir (2)";
	rm guia_certificado.pdf
else
	echo "inpi: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	rm guia_certificado.pdf
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v inpi|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
