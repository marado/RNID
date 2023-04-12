#!/bin/bash

wget https://business.turismodeportugal.pt/pt/Planear_Iniciar/Licenciamento_Registo_da_Atividade/Empreendimentos_Turisticos/Paginas/classificacao-et.aspx -o /dev/null -O - |hxnormalize -x -l 1000|hxselect .page-body > page-body
if [ ! "$(diff page-body scripts/35/page-body|wc -l)" -eq "0" ]; then
	echo "turismo: incumprimento pode já não existir";
else
	echo "turismo: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "business")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
rm page-body
