#!/bin/bash

# curl first to make sure the pages exist, then grep their contents to see if there's something there other than MapServer or FeatureServer now
curl -s --head https://sigservices.icnf.pt/server/rest/services/DFCI_PSF | head -n 1 | egrep "HTTP/1.[01] [23]..|HTTP/2 [23].." > /dev/null ; naopassa=$?
naopassa=$((naopassa + $(curl -s --head https://sigservices.icnf.pt/server/rest/services/DFCI | head -n 1 | egrep "HTTP/1.[01] [23]..|HTTP/2 [23].." > /dev/null ; echo $?)))
naopassa=$((naopassa + $(curl -s --head https://sigservices.icnf.pt/server/rest/services/GSTI | head -n 1 | egrep "HTTP/1.[01] [23]..|HTTP/2 [23].." > /dev/null ; echo $?)))
naopassa=$((naopassa + $(wget https://sigservices.icnf.pt/server/rest/services/DFCI_PSF -o /dev/null -O - | grep \<li\> |grep -v MapServer|grep -v FeatureServer|wc -l)))
naopassa=$((naopassa + $(wget https://sigservices.icnf.pt/server/rest/services/DFCI -o /dev/null -O - | grep \<li\> |grep -v MapServer|grep -v FeatureServer|wc -l)))
naopassa=$((naopassa + $(wget https://sigservices.icnf.pt/server/rest/services/GSTI -o /dev/null -O - | grep \<li\> |grep -v MapServer|grep -v FeatureServer|wc -l)))

if [ "$naopassa" -eq "0" ]; then
	echo "icnf: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "icnf")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "icnf: incumprimento resolvido";
fi
