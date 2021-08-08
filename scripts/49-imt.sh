#!/bin/bash

fail=0;
if [ "$(curl https://www.imt-ip.pt/sites/IMTT/Portugues/Formularios/Documents/Mod9IMT.pdf -o /dev/null; echo $?)" -eq "35" ]; then
	echo "imt: problema com o certificado SSL";
	fail=1;
fi

if [ "$fail" = 0 ]; then
	echo "imt: incumprimento pode já não existir";
else
	echo "imt: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v imt|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
