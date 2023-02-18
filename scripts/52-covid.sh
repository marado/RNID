#!/bin/bash

urls=$(for item in $(wget https://covid19.min-saude.pt/numero-de-novos-casos-e-obitos-por-dia/ -o /dev/null -O - | hxnormalize -x -l 1000| hxselect .wp-block-spms-accordion-item|hxselect a -s'\n'); do echo "$item"|grep href; done|cut -d\" -f2|grep -v ^$);

nurls=$(echo "$urls"|wc -l);
nnxls=$(echo "$urls"|grep -c -v xlsx);

if [ "$nurls" -eq "0" ]; then
	echo "covid: não foram encontrados urls, script não deve estar a funcionar correctamente.";
elif [ "$nnxls" -ne "0" ]; then
	echo "covid: há ($nnxls/$nurls) endereços que não são xlsx, incumprimento pode já não existir";
	echo "DEBUG: ";
	echo "$urls"|grep -n -v xlsx;
else
	echo "covid: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "covid19")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
