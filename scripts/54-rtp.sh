#!/bin/bash

url="https://www.rtp.pt/play/direto/rtp1"
url="https://www.rtp.pt/play/zigzag/p14295/e879403/escola-de-herois"

if [ "$(wget $url -o /dev/null -O - |grep -c 'drm: true')" -ne "1" ]; then
	echo "RTP: não encontrei DRM no stream testado, incumprimento pode já não existir";
else
	echo "RTP: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "rtp")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
