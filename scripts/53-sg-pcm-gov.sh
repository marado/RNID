#!/bin/bash

urls=$(for item in $(wget https://www.sg.pcm.gov.pt/servicos/fundacoes-e-entidades-de-utilidade-publica/ -o /dev/null -O - | hxnormalize -x -l 1000 | hxselect .file | hxselect a -s'\n'); do echo "$item" | grep href ; done | cut -d\" -f2);

nurls=$(echo "$urls" | grep -v '^$' | wc -l);
ndocx=$(echo "$urls" | grep -v '^$' |grep -c -v docx);

if [ "$nurls" -eq "0" ]; then
	echo "sg.pcm.gov.pt: não foram encontrados urls, script não deve estar a funcionar correctamente.";
	echo "DEBUG:"
	wget https://www.sg.pcm.gov.pt/servicos/fundacoes-e-entidades-de-utilidade-publica/ && cat index.html && rm index.html
elif ! [ "$ndocx/$nurls" = "4/8" ]; then
	echo "sg.pcm.gov.pt: existiam 4/8 endereços em .docx, e agora são ($ndocx/$nurls). Verificar se incumprimento se mantem";
	echo "NOTA: tentaste isto vindo dos IPs do github? Se sim, provavelmente bateste num 405 Method Not Allowed...";
else
	echo "sg.pcm.gov.pt: Incumprimento mantém-se, há ($ndocx/$nurls) endereços em .docx, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "sg.pcm.gov.pt")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
