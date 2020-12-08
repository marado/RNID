#!/usr/bin/env bash

set -ueo pipefail

if [ "$(gh -R https://github.com/amagovpt/access-monitor-plus issue view 14|grep ^state|cut -f2)" != "OPEN" ]; then
	echo "accessmonitor: incumprimento pode já não existir";
else
	echo "accessmonitor: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "accessmonitor")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
