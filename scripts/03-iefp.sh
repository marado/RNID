#!/bin/bash

# https://www.iefp.pt/ - não cumpre WCAG 2.0 AA

#TODO: find a good tool to make the validation on request
# https://achecker.ca/documentation/web_service_api.php - API usage depends on user account creation
# webaim.org - API's not gratis

# While we don't have a validator on request, let's find out if a known violation still exists
## 20/05/2018: - several images without an alt attribute:
if [ "$(wget https://www.iefp.pt/ -o /dev/null -O - | grep "<img" |grep -v alt|wc -l)" -eq "0" ]; then
	echo "iefp: incumprimento pode já não existir";
else
	echo "iefp: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v iefp|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
