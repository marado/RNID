#!/bin/bash

# Se a página onde está o .zip mudou, então pode apresentar também fontes alternativas
# Se a página não mudou, o .zip ainda assim pode ter sido actualizado para passar a ter normas abertas
different=0
wget https://www.dgterritorio.gov.pt/cartografia/cartografia-tematica/caop -o /dev/null

if [ "$(diff caop scripts/56/caop|wc -l)" -eq "0" ]; then
	curl -sI https://www.dgterritorio.gov.pt/sites/default/files/ficheiros-cartografia/Areas_Freg_Mun_Dist_Pais_CAOP2024.1.zip |grep last-modified > lm
	different=$(diff lm scripts/56/lm|wc -l)
	rm lm
fi

if [ ! "$different" -eq "0" ]; then
	echo "territorio: incumprimento pode já não existir";
else
	echo "territorio: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "territorio")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
rm caop
