#!/bin/bash

# Apesar do processo ser através do portal do cidadão Lisboeta, com um
# formulário web e tal, a determinada altura o forumlário pede que se
# descarregue este ficheiro, preencha, e anexe ao formulário web...
if [ "$(wget https://informacoeseservicos.lisboa.pt/fileadmin/informacoes_servicos/pedidos/_transversais/CML_participacao_ocorrencia.pdf -o /dev/null -O - | strings | grep -i XFA -c)" -eq "0" ]; then
	echo "lisboa-pdf: incumprimento pode já não existir";
else
	echo "lisboa-pdf: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v www.cm-lisboa|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
	done < README.md > new
	mv new README.md
fi
