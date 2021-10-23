#!/bin/bash

fail=0;

# Testing HTTPS
if [ "$(curl https://www.imt-ip.pt/sites/IMTT/Portugues/Formularios/Documents/Mod9IMT.pdf -o /dev/null; echo $?)" -eq "35" ]; then
	echo "imt: problema com o certificado SSL";
	fail=1;
fi

# Testing HTTPS
if [ "$(curl https://www.imt-ip.pt/sites/IMTT/Portugues/Formularios/Documents/Mod9IMT.pdf -o /dev/null; echo $?)" -eq "60" ]; then
	echo "imt: problema com o certificado SSL";
	fail=2;
fi

# https://www.imt-ip.pt/ - não cumpre WCAG 2.0 AA (nem A)
## 23/10/2021: there are empty alts
emptyalt=$(curl -k -L https://www.imt-ip.pt/ | hxclean | hxselect -s '\n' img | hxselect -s '\n' -c 'img::attr(alt)'|grep -c ^$);
if [ "$emptyalt" -ne "0" ]; then
	echo "imt: problemas de acessibilidade";
	fail=3;
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

# https://servicos.imt-ip.pt/ - não cumpre WCAG 2.0 AA (nem A)
## 23/10/2021: there are empty alts
emptyalt=$(curl -k -L https://servicos.imt-ip.pt/ | hxclean | hxselect -s '\n' img | hxselect -s '\n' -c 'img::attr(alt)'|grep -c ^$);
if [ "$emptyalt" -ne "0" ]; then
	echo "imt: problemas de acessibilidade";
	fail=3;
fi
