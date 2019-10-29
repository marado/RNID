#!/bin/bash

docs="$(for a in $(wget https://www.norte2020.pt/investimento-municipal -o /dev/null -O - |hxnormalize -x -l 1000|hxselect .a-dload); do echo "$a"|grep -i http; done)";
dcount=$(echo "$docs"|wc -l);
xls=$(echo "$docs"|grep -c -i xls)

if [ "$dcount" -eq "0" ]; then
	echo "norte2020: incumprimento pode já não existir (1)";
elif [ ! "$dcount" -eq "$xls" ]; then
	echo "norte2020: incumprimento pode já não existir (2)";
else
	echo "norte2020: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "norte2020")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
