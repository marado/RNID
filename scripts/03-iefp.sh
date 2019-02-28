#!/bin/bash

# https://www.iefp.pt/ - não cumpre WCAG 2.0 AA

#TODO: find a good tool to make the validation on request
# https://achecker.ca/documentation/web_service_api.php - API usage depends on user account creation
# webaim.org - API's not gratis

# While we don't have a validator on request, let's find out if a known violation still exists
## 20/05/2018: - several images without an alt attribute:
## 28/02/2019: the missing alts case is no longer a problem, but to comply with WCAG the XHTML also needs to be valid...
##             https://validator.w3.org/nu/?doc=https%3A%2F%2Fwww.iefp.pt%2F
##             tidy is a great validator, but isn't catching the errors on this
##             page as errors, even if it shows them as warnings... let's be hacky and pay
##             attention only on the current use case:
#if [ "$(wget https://www.iefp.pt/ -o /dev/null -O - | grep "<img" |grep -v alt|wc -l)" -eq "0" ]; then
if [ "$(wget https://www.iefp.pt/ -o /dev/null -O -| tidy -e 2>&1|grep proprietary|wc -l)" -eq "0" ]; then
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
