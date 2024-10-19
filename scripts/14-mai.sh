#!/bin/bash

wget --no-check-certificate https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx -o /dev/null -O -|grep -v __REQUESTDIGEST|grep -v VIEWSTATE|hxnormalize -x -l 1000|hxselect .conteudo > mai-tmp
if [ $? -eq 4 ]; then
	echo "mai: Network error. Site em baixo? Rede bloqueada?";
	exit;
fi

cat mai-tmp|hxselect a -s'\n' > mai
if [ ! "$(diff mai scripts/14/mai|wc -l)" -eq "0" ]; then
	echo "mai: incumprimento pode já não existir";
	echo "DEBUG: mai-tmp:"
	cat mai-tmp
	echo "EOF"
	echo "EXTRA DEBUG:"
	# wget --no-check-certificate https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx && cat default.aspx && rm default.aspx
	echo "wget's return code is:"
	wget --no-check-certificate https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx ; echo $?
	rm default.aspx
else
	echo "mai: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -c -v sg.mai)" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm mai-tmp mai
