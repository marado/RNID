#!/bin/bash

files=$(
	for i in $(wget https://bud.gov.pt/ddn/dispensa/requerer.html -o /dev/null -O -); do echo $i; done | \
		grep href|cut -d\" -f2|grep -v html$|grep -v ^#|grep -v ^http|grep -v "\.css"|grep -v png$|grep -v ico$
);
nfiles=$(echo "$files"|wc -l);
docs=$(echo "$files"|grep .docx$|wc -l);

if [ "$nfiles" != 1 ] || [ "$docs" != 1 ]; then
	echo "bud: incumprimento pode já não existir";
else
	echo "bud: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v bud|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
