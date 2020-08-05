#!/bin/bash

# curl -s --head https://www.inventarios.pt/documentos/manual_instalacao_gosign_v4.pdf | head -n 1 | egrep "HTTP/1.[01] [23]..|HTTP/2 [23].." > /dev/null ; naopassa=$?
naopassa=$(wget --spider https://www.inventarios.pt/documentos/manual_instalacao_gosign_v4.pdf -o -|grep ^HTTP|head -n1|grep "200 OK"|wc -l)

if [ "$naopassa" -eq "1" ]; then
	echo "inventarios: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "inventarios")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "inventarios: incumprimento resolvido";
fi
