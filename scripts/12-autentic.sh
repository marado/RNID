#!/bin/bash

# https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx - pagina com informacao sobre o plugin

wget https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx -o /dev/null -O - | hxnormalize -x -l 1000 2> /dev/null |hxselect .info-box > autenticacaogovpt.aspx
if [ ! "$(diff autenticacaogovpt.aspx scripts/12/autenticacaogovpt.aspx|wc -l)" -eq "0" ]; then
	echo "autenticação: incumprimento pode já não existir";
else
	echo "autenticação: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v autenticacao|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm autenticacaogovpt.aspx
