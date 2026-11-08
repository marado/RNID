#!/bin/bash

## This script should only run the scripts that test things that cannot be
## automatically tested by Github Actions due to network restrictions.

if [ -e scripts/manual.sh ]; then
    ./scripts/26-snirh.sh
    ./scripts/48-insa.sh

	echo ""
	echo "Falta testar manualmente o incumprimento da CMLisboa:"
	echo "1. ir a https://servicos.lisboa.pt/fileadmin/servicos/pedidos/transversais/LLO/CML_participacao_ocorrencia.pdf no browser e guardar o PDF"
	echo "2. fazer um 'file CML_participacao_ocorrencia.pdf' e ver se o PDF continua a ser 1.5 ou já é 1.7 como dita a norma"
	echo "3. actualizar o README"
else
    echo "Estás a correr isto a partir da directoria certa?"
fi
