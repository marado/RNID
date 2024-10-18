#!/bin/bash

#	https://www.portalviva.pt/31889.aspx
# https://www.portalviva.pt/pt/homepage/onde-carregar/portal-viva.aspx

# Nota: https://www.portalviva.pt/lx/pt/public/client-register-modes.aspx
# também pode ser um bom link para usar e validar (registar na secção "Com
# cartão de cidadão | Conta VIVA +" manda instalar o Java).

wget "https://www.portalviva.pt/pt/homepage/onde-carregar/portal-viva.aspx" -O - -o /dev/null |hxnormalize -x -l 1000|hxselect .contentViva > viva
if [ ! "$(diff viva scripts/20/viva|wc -l)" -eq "0" ]; then
	echo "viva: incumprimento pode já não existir";
else
	echo "viva: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v viva|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm viva
