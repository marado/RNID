#!/bin/bash

# | https://snirh.apambiente.pt/ | XHTML inválido, CSS inválido | [análise do XHTML](https://validator.w3.org/check?uri=https%3A%2F%2Fsnirh.apambiente.pt&charset=%28detect+automatically%29&doctype=Inline&group=0), [análise do CSS](https://jigsaw.w3.org/css-validator/validator?uri=https%3A%2F%2Fsnirh.apambiente.pt&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en) | 2018/06/01 ||

maybeOK=0;

# Test disabled as the website seems to be 403ing the request
# xhtmlErrors=$(wget "https://validator.w3.org/check?uri=https%3A%2F%2Fsnirh.apambiente.pt&charset=%28detect+automatically%29&doctype=Inline&group=0" -o /dev/null -O - |hxnormalize -x -l 1000|hxselect .invalid|hxselect h3 -c|cut -d: -f2|cut -d" " -f2)
# if [ "$xhtmlErrors" -eq "0" ]; then
# 	echo "xhtml snirh: incumprimento já não existe";
# 	maybeOK=1;
# fi

wget "https://jigsaw.w3.org/css-validator/validator?uri=https%3A%2F%2Fsnirh.apambiente.pt&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en" -o /dev/null -O - |grep \#errors|cut -d\> -f3|cut -d\< -f1 > css
if [ ! "$(diff css scripts/26/css|wc -l)" -eq "0" ]; then
	echo "css snirh: incumprimento pode já não existir";
	maybeOK=1;
fi
rm css

if [ "$maybeOK" -eq "0" ]; then
	echo "snirh: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v snirh|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
