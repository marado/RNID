#!/bin/bash

flash=$(wget http://www.institutogamapinto.com/ -o /dev/null -O -|grep -c mediaplayer.swf)

if [ ! "$flash" -eq "1" ]; then
	echo "pinto: incumprimento pode já não existir (1)";
else
	echo "pinto: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "pinto")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
