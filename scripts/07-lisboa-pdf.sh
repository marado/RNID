#!/bin/bash

# Apesar do processo ser através do portal do cidadão Lisboeta, com um
# formulário web e tal, a determinada altura o formulário pede que se
# descarregue este ficheiro, preencha, e anexe ao formulário web...
#
# O site da CML está atrás da protecção anti-bot da Cloudflare. Este
# script NÃO tenta contornar essa protecção. Tenta os URLs oficiais
# conhecidos; se a transferência for bloqueada (desafio Cloudflare,
# HTML em vez de PDF, etc.), reporta "bloqueado/desconhecido" e não
# altera o README — evita um falso "incumprimento pode já não existir".
# A versão do PDF é lida do cabeçalho %PDF-1.x (não depende do comando
# `file`).

# URLs oficiais publicados pela CML para o mesmo formulário. Pode ser
# substituído em testes com LISBOA_PDF_URLS (lista separada por espaços).
URLS=(
	"https://informacoeseservicos.lisboa.pt/fileadmin/informacoes_servicos/pedidos/_transversais/CML_participacao_ocorrencia.pdf"
	"https://servicos.lisboa.pt/fileadmin/servicos/pedidos/transversais/LLO/CML_participacao_ocorrencia.pdf"
)
if [ -n "${LISBOA_PDF_URLS:-}" ]; then
	# shellcheck disable=SC2206
	URLS=($LISBOA_PDF_URLS)
fi

WORKDIR="${TMPDIR:-/tmp}"
BODY=$(mktemp "$WORKDIR/lisboa-pdf-body.XXXXXX")
HDR=$(mktemp "$WORKDIR/lisboa-pdf-hdr.XXXXXX")
cleanup() { rm -f "$BODY" "$HDR"; }
trap cleanup EXIT

# transfere $1 para $BODY/$HDR; imprime o código HTTP (000 se a rede falhar)
fetch() {
	local url="$1"
	: > "$BODY"
	: > "$HDR"
	curl -sS -L --max-time 30 --max-redirs 5 \
		-A "RNID-compliance-check (+https://github.com/marado/RNID)" \
		-D "$HDR" -o "$BODY" -w "%{http_code}" "$url" 2>/dev/null \
		|| echo "000"
}

is_pdf() {
	# %PDF- no início, ignorando BOM/espaços iniciais
	local sig
	sig=$(dd if="$BODY" bs=16 count=1 2>/dev/null | tr -d '\000')
	case "$sig" in
		"%PDF-"*) return 0 ;;
		*) return 1 ;;
	esac
}

pdf_version() {
	dd if="$BODY" bs=16 count=1 2>/dev/null \
		| tr -d '\r\000' \
		| sed -n 's/^%PDF-\([0-9][0-9]*\.[0-9][0-9]*\).*/\1/p'
}

is_blocked() {
	local code="$1"
	# Cabeçalhos explícitos do desafio Cloudflare, ou um corpo HTML
	# quando o pedido não devolveu um PDF.
	if grep -qiE '^cf-mitigated:[[:space:]]*challenge' "$HDR"; then
		return 0
	fi
	if grep -qiE '^content-type:[[:space:]]*text/html' "$HDR" && ! is_pdf; then
		return 0
	fi
	if ! is_pdf; then
		if grep -qiE 'Just a moment|cdn-cgi/challenge|__cf_bm|cloudflare' "$BODY" "$HDR"; then
			return 0
		fi
		# 403/429/503 sem PDF: tratado como bloqueio, não como
		# "o ficheiro deixou de existir" (isso seria um 404 com HTML
		# de erro normal — ainda assim, sem PDF não afirmamos nada).
		case "$code" in
			403|429|503) return 0 ;;
		esac
	fi
	return 1
}

got_pdf=
http_code=
blocked_all=0
tried=0
not_found=0

for url in "${URLS[@]}"; do
	tried=$((tried + 1))
	http_code=$(fetch "$url")
	# curl -w em caso de falha da nossa função já devolve 000\n possivelmente
	http_code=$(echo "$http_code" | tail -n 1)

	if is_pdf; then
		got_pdf=1
		break
	fi
	if [ "$http_code" = "404" ]; then
		not_found=$((not_found + 1))
		continue
	fi
	if is_blocked "$http_code"; then
		blocked_all=1
		continue
	fi
	# Resposta inesperada (rede, 000, outro HTML): também não é conclusão.
	blocked_all=1
done

if [ -n "$got_pdf" ]; then
	version=$(pdf_version)
	if [ "$version" = "1.5" ]; then
		echo "lisboa-pdf: Incumprimento mantém-se (PDF $version), a actualizar o README (faça um git diff, valide, e commit!)";
		while IFS='' read -r line || [[ -n "$line" ]]; do
			test $(echo "$line"|grep -v www.cm-lisboa|wc -l) -eq "1" \
				&& echo "$line" \
				|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); nc=$(echo "$line"|cut -d\| -f5 | wc -m); printf "%s| %-$((nc-2))s|%s\n" "$h" "$(date +%Y/%m/%d)" "$t");
		done < README.md > new
		mv new README.md
	else
		echo "lisboa-pdf: incumprimento pode já não existir (PDF ${version:-desconhecida}, esperado 1.5)";
	fi
	exit 0
fi

if [ "$not_found" -eq "$tried" ] && [ "$tried" -gt 0 ]; then
	echo "lisboa-pdf: PDF já não está acessível? (HTTP 404 em todos os URLs oficiais)";
	exit 0
fi

echo "lisboa-pdf: bloqueado/desconhecido — a transferência do PDF oficial foi impedida (Cloudflare ou resposta que não é PDF, HTTP ${http_code:-?}). O README não é alterado; é necessária uma validação manual."
exit 0
