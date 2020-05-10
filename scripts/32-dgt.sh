#!/bin/bash

naopassa=$(wget http://www.dgterritorio.pt/cartografia_e_geodesia/cartografia/cartografia_de_base___topografica_e_topografica_de_imagem/serie_cartografica_1500_000/ -o /dev/null -O - |html2text|grep atualiz|grep :|cut -d: -f2|grep -c 2017)
naopassa=$((naopassa + $(wget http://www.dgterritorio.pt/cartografia_e_geodesia/cartografia/carta_administrativa_oficial_de_portugal_caop/caop__download_/carta_administrativa_oficial_de_portugal___versao_2018__em_vigor_/ -o /dev/null -O - |html2text|grep atualiz|grep :|cut -d: -f2|grep -c "janeiro de 2019")))
# TODO: complementar validações com o incumprimento do XLS

if [ "$naopassa" -ge "1" ]; then
	echo "dgt: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgterritorio")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "dgt: incumprimentos potencialmente resolvidos (verificar cada uma deles manualmente!)";
fi
