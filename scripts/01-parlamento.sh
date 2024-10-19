#!/bin/bash

# Incumprimentos: Vídeos disponibilizados em WMV, Canal Parlamento em Flash

## a) Vídeos disponibilizados em WMV
wget 'http://www.parlamento.pt/ActividadeParlamentar/Paginas/DetalheAudiencia.aspx?BID=99371' -o /dev/null -O - | \
	hxnormalize -x -l 10000 2>/dev/null | grep "Links associados" -A 100 | \
	grep "Bottom Fixed Nav" -B 100 | hxnormalize -x -l 10000|hxselect a -s '\n'|hxnormalize|grep href|cut -d\" -f2 > tmp

a=$(diff tmp scripts/01/DetalheAudiencia.aspx?BID=99371 |wc -l)
# Se $a for 0, então o incumprimento mantém-se
rm tmp

## b) Canal Parlamento em Flash
b=0; # 0 significa que incumprimento mantém-se
test $(wget --no-check-certificate https://canal.parlamento.pt/ -o /dev/null -O -|grep embedplayer.min.js|wc -l) -eq "1" \
	&& (
		wget --no-check-certificate https://canal.parlamento.pt/scripts/embedplayer.min.js -o /dev/null;
		test "$(diff embedplayer.min.js scripts/01/embedplayer.min.js|wc -l)" -eq "0" || b=1;
		rm embedplayer.min.js;
	) || b=2

## resultados:
if [ ! "$a" -eq "0" ]; then
	echo "parlamento: Incumprimento 'a' (videos em wmv) pode estar resolvido.";
fi
if [ ! "$b" -eq "0" ]; then
	echo "parlamento: Incumprimento 'b' (flash no canal paralamento) pode estar resolvido ($b).";
fi
if [ $((a + b)) -eq "0" ]; then
	echo "parlamento: incumprimento mantém-se, a actualizar README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v www.parlamento.pt|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
else
	# TODO: fazer disto o teste (c) (e meter este incumprimento também no README)
    ## c) certificado mal configurado
    ##   -- https://whatsmychaincert.com/?canal.parlamento.pt
    ##   -- TODO: escrever o teste!
	echo "https://www.canal.parlamento.pt/ ainda tem problemas de https?";
fi
