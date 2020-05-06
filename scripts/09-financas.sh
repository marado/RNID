#!/bin/bash

# Financas, varios incumprimentos:

# a) XLS, XLSX e DOC
#    http://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/tabela_ret_doclib/Pages/default.aspx
# b) endereços e contactos em XLSX
#    https://www.portaldasfinancas.gov.pt/pt/contactosEbalcao.action
# c) lista de formulários, quase na totalidade em formatos proprietários
#    http://info-aduaneiro.portaldasfinancas.gov.pt/pt/publicacoes_formularios/formularios/Pages/formularios.aspx
# d) efacturas -- exportação de facturas depende de flash
# e) Enviar Ficheiro SAF-T exige Java -- https://faturas.portaldasfinancas.gov.pt/enviarSaftAppletForm.action

# Visto que para um destes casos podem os ficheiros continuar disponíveis e o
# incumprimento ser à mesma resolvido atravás da disponibilização, em paralelo,
# dos documentos em formatos abertos, este teste vai "jogar pelo seguro" e
# dizer que o incumprimento pode já estar resolvido (obrigando a uma revisão
# manual) caso a página tenha mudado

# FIXME: voltar a validar o cenário (a) (precisa de ser actualizado que agora há a tabela de 2020)
# # (a)
# wget "http://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/tabela_ret_doclib/_vti_bin/portalat/docs.svc/groupeddocs?fields=DocIcon,Title,FileSizeDisplay&groups=Year:DESC&selectedvalues=2018&filter=<IsNotNull><FieldRef Name=\"ID\"></FieldRef></IsNotNull>&sort=Year:DESC,Title:DESC&id=27" -o /dev/null -O docs-2018
# a=$(diff docs-2018 scripts/09/docs-2018|wc -l)
# rm docs-2018
# if [ ! "$a" -eq "0" ]; then
# 	echo "financas: 'documentos XLS, XLSX e DOC' pode já estar resolvido.";
# fi

# FIXME: voltar a validar o cenário (b), agora em http://info.portaldasfinancas.gov.pt/pt/dgci/contactos_servicos/enderecos_contactos/Pages/contactos.aspx
# # (b)
# wget https://www.portaldasfinancas.gov.pt/pt/contactosEbalcao.action -o /dev/null -O -|grep -i "Lista de Contactos" > contactos
# b=$(diff contactos scripts/09/contactos|wc -l)
# rm contactos
# if [ ! "$b" -eq "0" ]; then
# 	echo "financas: incumprimento nos contactos pode já estar resolvido.";
# fi

# (c)
wget "http://info-aduaneiro.portaldasfinancas.gov.pt/pt/publicacoes_formularios/formularios/_vti_bin/portalat/docs.svc/listdocs?fields=DocIcon,Modelo,Title&sort=Seq:ASC,Seq_2:ASC,Title:ASC&filter=<IsNotNull><FieldRef Name=\"ID\"></FieldRef></IsNotNull>&id=35" -o /dev/null -O forms
c=$(diff forms scripts/09/forms|wc -l)
rm forms

# (d) && (e)
# TODO

if [ ! "$c" -eq "0" ]; then
	echo "financas: incumprimento nos formulários pode já estar resolvido.";
fi

if [ "$((a + b + c))" -eq "0" ]; then
	echo "financas: Incumprimentos mantêm-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v financas|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
else
	echo "financas: Incumprimentos podem estar resolvidos.";
fi
