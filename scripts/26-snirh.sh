#!/bin/bash

# | https://snirh.apambiente.pt/ | XHTML inválido, CSS inválido | [análise do XHTML](https://validator.w3.org/check?uri=https%3A%2F%2Fsnirh.apambiente.pt&charset=%28detect+automatically%29&doctype=Inline&group=0), [análise do CSS](https://jigsaw.w3.org/css-validator/validator?uri=https%3A%2F%2Fsnirh.apambiente.pt&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en) | 2018/06/01 ||
#
# We used to have the HTML and CSS tested automagically with w3 validators, but they were blocked by APA.
# Very well, we'll test those errors manually...
#
# At 28/01/2026 there were 107 HTML errors detected on the front page.
# We're testing just the first of them, to see if it still exists:
#
# We have a line like this:
# <link href="/_classes/css/gp-buttons/css/css3-buttons.css" rel="stylesheet" type="text/css" media="screen">
# which is an error: end tag for "link" omitted, but OMITTAG NO was specified
# The solution should be: perhaps you meant to "self-close" an element, that is, ending it with "/>" instead of ">".
# Let's see if the issue is still there:
xhtmlErrors=$(wget "https://snirh.apambiente.pt/" -o /dev/null -O -|grep media=\"screen|grep -v /\>|wc -l);

if [ "$xhtmlErrors" -eq "0" ]; then
	echo "snirh: detalhe do incumprimento que foi testado já não existe, incumprimento pode estar resolvido (testar manualmente)";
else
	echo "snirh: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v snirh|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
