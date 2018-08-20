#!/bin/bash

if [ ! "$(wget https://www.sg.mai.gov.pt/ -o -|grep cert -c)" -eq "2" ]; then
    echo "certificado mai: incumprimento pode já não existir";
else
	wget --no-check-certificate https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx -o /dev/null -O -|grep -v __REQUESTDIGEST|grep -v VIEWSTATE > mai
	if [ ! "$(diff mai scripts/14/mai|wc -l)" -eq "0" ]; then
		echo "mai: incumprimento pode já não existir";
	else
		echo "mai: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
		while IFS='' read -r line || [[ -n "$line" ]]; do
			test "$(echo "$line"|grep -c -v sg.mai)" -eq "1" \
				&& echo "$line" \
				|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
		done < README.md > new
		mv new README.md
	fi
	rm mai
fi
