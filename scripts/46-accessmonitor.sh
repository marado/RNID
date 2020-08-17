#!/usr/bin/env bash

set -ueo pipefail

if curl -L -w "%{url_effective}\n" "http://accessmonitor.acessibilidade.gov.pt/ams/" | grep "^https" > /dev/null; then
	echo "accessmonitor: incumprimento pode já não existir";
else
	echo "pcm: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "accessmonitor")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
