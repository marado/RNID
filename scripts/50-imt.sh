#!/bin/bash

# https://www.imt-ip.pt/ - não cumpre WCAG 2.0 AA (nem A)

#TODO: find a good tool to make the validation on request
# https://achecker.ca/documentation/web_service_api.php - API usage depends on user account creation
# webaim.org - API's not gratis

# While we don't have a validator on request, let's find out if a known violation exists

## 23/10/2021: there are empty alts

emptyalt=$(curl -k -L https://www.imt-ip.pt/ | hxclean | hxselect -s '\n' img | hxselect -s '\n' -c 'img::attr(alt)'|grep -c ^$);

if [ "$emptyalt" -eq "0" ]; then
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
