#!/bin/bash

fail=0;

if [ "$(curl https://tcp.dgterritorio.gov.pt/procurar -o /dev/null --silent; echo $?)" -eq "60" ]; then
	echo "dgt: erro no certificado HTTPS";
	fail=1;
else
	links="$(wget https://tcp.dgterritorio.gov.pt/procurar -o /dev/null -O -|hxnormalize -x -l 10000|hxselect .feed-icon|hxselect a -s '\n')";

	# How many links are there? if there is less than 1, something has changed,
	# validate manually. If there are more than 1, maybe there's a XLS but also
	# other (open) format. Let's validate manually and adjust the script if the
	# violation stands.
	nlinks="$(echo "$links"|wc -l)";
	xls="$(echo "$links"|grep -c -i xls)";

	# TODO: complementar validações com o incumprimento do XLS

	if [ "$nlinks" -eq "1" ] && [ "$xls" -eq "1" ]; then
		echo "dgt: continua o incumprimento com o uso de XLS";
		fail=2;
	fi
fi

if [ "$fail" = 0 ]; then
	echo "dgt: algo mudou (nlinks $nlinks, xls $xls), incumprimento potencialmente resolvido (verificar manualmente!)";
else
	echo "dgt: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "dgterritorio")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
