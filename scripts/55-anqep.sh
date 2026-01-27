#!/bin/bash

# ufcdPesquisa (HTML) includes a few javascripts, including two main-es*5.*js , which are the ones that show that we're getting XLS results
# As long as those two imports remain the same, so does the RNID violation...
wget https://catalogo.anqep.gov.pt/ufcdPesquisa -o /dev/null
if [ $? -ne 0 ]; then
	echo "anqep: o site parece indisponível, incumprimento pode já não existir";
elif [ ! "$(diff ufcdPesquisa scripts/55/ufcdPesquisa|wc -l)" -eq "0" ]; then
	echo "anqep: incumprimento pode já não existir";
else
	echo "anqep: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "anqep")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm -f ufcdPesquisa
