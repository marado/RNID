#!/bin/bash

if [ "$(wget --no-check-certificate "https://www.precoscombustiveis.dgeg.pt/pagina.aspx?screenwidth=1920&mlkid=pciumvukbs2o1z55tmon3ae3&menucb=1&cn=6160AAAAAAAAAAAAAAAAAAAA" -o /dev/null -O -|grep Flash -c)" -eq "0" ]; then
	echo "combustiveis: incumprimento pode já não existir";
	echo "              ...mas há que validar se o problema do HTTPS também já desapareceu."; # o wget funciona sem o --no-check-certificate ?
else
	echo "combustiveis: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "combustiveis")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
