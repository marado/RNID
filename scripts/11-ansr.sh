#!/bin/bash

# http://www.ansr.pt/Contraordenacoes/Formularios/Pages/default.aspx - docx's

wget http://www.ansr.pt/Contraordenacoes/Formularios/Pages/default.aspx -o /dev/null -O -|grep -v __REQUESTDIGEST |grep -v VIEWSTATE|grep -v f5_cspm> default.aspx
if [ ! "$(diff default.aspx scripts/11/default.aspx|wc -l)" -eq "0" ]; then
	echo "ansr: incumprimento pode já não existir";
else
	echo "ansr: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v ansr|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm default.aspx
