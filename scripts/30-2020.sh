#!/bin/bash

naopassa=$(wget https://www.portugal2020.pt/Portal2020/Media/Default/Videos/Login_12_11_2014.htm -O - -o /dev/null|grep EMBED|grep -c swf);

if [ "$naopassa" -eq "1" ]; then
	echo "2020: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "2020")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "2020: incumprimento resolvido";
fi
