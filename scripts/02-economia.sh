#!/bin/bash

if [ ! "$(curl -s -I https://www.dgae.gov.pt/gestao-de-ficheiros-externos-dgae-ano-2015/1_formulario-registo_mf_nao_harmonizadas-doc.aspx|grep filename|cut -d= -f2| tr -d '\r')" == "i010066.doc" ]; then
	echo "economia: incumprimento pode já não existir";
else
	echo "economia: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v min-economia|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
