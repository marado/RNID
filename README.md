Esta lista, regularmente actualizada, regista ocorrências ou reportadas à ANSOL, ou observadas pela ANSOL, de sítios web que não usam Normas Abertas, como especificado na Lei das Normas Abertas.

Mais informação sobre a Lei das Normas Abertas [no site da ANSOL](https://ansol.org/iniciativas/monitorizacao-rnid/). As normas no RNID também se encontram listadas [aqui](RNID.md).

Na eventualidade de teres encontrado incumprimento das Normas Abertas, podes reportar da seguinte forma, abrir um [issue no github](https://github.com/marado/RNID/issues/new/choose), ou enviares um email para [contacto@ansol.org](mailto:contacto@ansol.org).

# Normas de acessibilidade

Com a introdução do [Observatório Português de Acessibilidade
Web](https://observatorio.acessibilidade.gov.pt/), decidimos não nos focar nos
incumprimentos dessa natureza para não duplicar esforços.


# Ocorrências de incumprimento

[![Validação automática](https://github.com/marado/RNID/actions/workflows/scripts.yml/badge.svg)](https://github.com/marado/RNID/actions/workflows/scripts.yml)

Esta tabela mostra casos de incumprimento do regulamento:

| Sítio Web                                    | Incumprimento                                                                                                                      | Exemplo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Última avaliação | Pedido de Resolução |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- | ------------------- |
| www.parlamento.pt                            | Vídeos disponibilizados em [WMV](https://ansol.org/recursos/normas-abertas/wmv/)                                                                          | [vídeo de audição](http://www.parlamento.pt/ActividadeParlamentar/Paginas/DetalheAudiencia.aspx?BID=99371)                                                                                                                                                                                                                                                                                                                                                                                        | 2024/09/23 | 2015/03/25          |
| www.dgae.min-economia.pt                     | Microsoft Office                                                                                                                   | [página com formulários OOXML](http://www.dgae.gov.pt/documentacao-/formularios.aspx)                                                                                                                                                                                                                                                                                                                                                                                                             | 2024/09/23 | 2015/03/25          |
| http://www.cm-lisboa.pt/                     | PDF com XFA                                                                                                                        | [PDF com XFA](https://informacoeseservicos.lisboa.pt/fileadmin/informacoes_servicos/pedidos/_transversais/CML_participacao_ocorrencia.pdf)                                                                                                                                                                                                                                                                                                                                                                                    | 2024/09/23 | 2019/04/23          |
| Portais do Ministério das Finanças           | Diversos incumprimentos                                                                                                            | [XLS, XLSX e DOC](http://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/tabela_ret_doclib/), [lista de formulários, quase na totalidade em formatos proprietários](http://info-aduaneiro.portaldasfinancas.gov.pt/pt/publicacoes_formularios/formularios/Pages/formularios.aspx) | 2024/09/09 | 2017/03/25          |
| https://www.autenticacao.gov.pt/             | Precisa de [extensão autenticacao.gov.pt](https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx#installAgent) para funcionar | [autenticação](https://www.autenticacao.gov.pt/web/guest/cartao-cidadao/autenticacao)                                                                                                                                                                                                                                                                                                                                                                                                                      | 2024/09/23 |                     |
| http://www.sg.mai.gov.pt                     | XLS                                                                                                                                | [cadernos eleitorais](http://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx)                                                                                                                                                                                                                                                                                                                                                        | 2024/09/23 | 2016/01/28          |
| http://www.rcaap.pt/                         | obriga depósito de dados em formatos não-livres ([lista de formatos autorizados](https://dre.pt/application/conteudo/72779297))    | [MP3](https://ansol.org/recursos/normas-abertas/mp3/)                                                                                                                                                                                                                                                                                                                                                                                                                                             | 2024/09/23 |                     |
| https://www.igcp.pt/                         | XLS                                                                                                                                | [conteúdo em XLS](https://www.igcp.pt/pt/gca/?id=80)                                                                                                                                                                                                                                                                                                                                                                                                                                              | 2024/09/23 | 2019/05/14          |
| https://www.portalviva.pt/                   | Java                                                                                                                               | [necessita plugin JAVA](https://www.portalviva.pt/lx/pt/myvivaclient/client-account-area/loads/new-load.aspx) [(outro exemplo)](https://www.portalviva.pt/lx/pt/public/client-register-modes.aspx)                                                                                                                                                                                                                                                                                                | 2024/09/23 | 2020/05/04          |
| https://www.eleicoes.mai.gov.pt/             | acessibilidade, CSS inválido                                                                                                       | [exemplo de página com erros WCAG](https://www.eleicoes.mai.gov.pt/europeias2019/estrangeiro.html), [análise de um CSS](https://jigsaw.w3.org/css-validator/validator?uri=https%3A%2F%2Fwww.eleicoes.mai.gov.pt%2Fautarquicas2017%2F&profile=css3svg&usermedium=all&warning=1&vextwarning=&lang=en)                                                                                                                                                                                               | 2024/09/23 |                     |
| https://apambiente.pt/                       | XHTML inválido, CSS inválido, HTTPS inválido, Conteúdo Flash, OOXML                                                                | [análise do XHTML](https://validator.w3.org/check?uri=https%3A%2F%2Fsnirh.apambiente.pt&charset=%28detect+automatically%29&doctype=Inline&group=0), [análise do CSS](https://jigsaw.w3.org/css-validator/validator?uri=https%3A%2F%2Fsnirh.apambiente.pt&profile=css3&usermedium=all&warning=1&vextwarning=&lang=en), [documentos OOXML](https://apambiente.pt/residuos/fluxos-especificos-de-residuos)                                                                                           | 2024/09/22 | 2020/05/16          |
| https://inpi.justica.gov.pt                  | Serviços necessitam JAVA                                                                                                           | [documento com instruções](https://servicosonline.inpi.pt/registos/guia_certificado.pdf)                                                                                                                                                                                                                                                                                                                                                                                                          | 2024/09/23 |                     |
| https://www.turismodeportugal.pt/             | Informação apenas em XLSX                                                                                                          | [página com vários links para informação apenas em XLSX](https://business.turismodeportugal.pt/pt/Planear_Iniciar/Licenciamento_Registo_da_Atividade/Empreendimentos_Turisticos/Paginas/classificacao-et.aspx)                                                                                                                                                                                                                                                                                     | 2024/09/23 | 2022/02/22          |
| https://www.norte2020.pt/                    | Informação apenas em XLSX                                                                                                          | [página com documento apenas em XLSX](https://www.norte2020.pt/investimento-municipal)                                                                                                                                                                                                                                                                                                                                                                                                            | 2024/09/23 | 2019/10/29          |
| https://www.sef.pt/                          | Documentos em .doc                                                                                                                 | [Documentos em .doc no final da página](https://www.sef.pt/pt/pages/conteudo-detalhe.aspx?nID=73)                                                                                                                                                                                                                                                                                                                                                                          | 2024/09/23 |                     |
| http://www.insa.min-saude.pt                 | XLSX                                                                                                                               | [dados do R(t) em XLSX](http://www.insa.min-saude.pt/category/areas-de-atuacao/epidemiologia/covid-19-curva-epidemica-e-parametros-de-transmissibilidade/)                                                                                                                                                                                                                                                                                                                                        | 2024/08/28 | 2021/03/12          |
| https://bud.gov.pt/ | Documento em .doc | [página com formulário em .doc, sem outra alternativa](https://bud.gov.pt/ddn/dispensa/requerer.html) | 2024/09/23 ||
| https://www.dgeg.gov.pt/ | Documentos em .xlsx | [página com documentos em formato XLSX, sem outra alternativa](https://www.dgeg.gov.pt/pt/estatistica/energia/petroleo-e-derivados/vendas-mensais/) | 2024/09/01 ||
| https://covid19.min-saude.pt | Documentos em .xlsx | [página com documentos em formato XLSX, sem outra alternativa](https://covid19.min-saude.pt/numero-de-novos-casos-e-obitos-por-dia/) | 2024/08/28 ||

Este [template](template.txt) é utilizado pela ANSOL e pela Comunidade LibreOffice Portugal para enviar um pedido de resolução do problema.

Para correr todos os scripts de validação de uma só vez, pode-se fazer:
```
$ for i in scripts/*sh; do bash $i; done
```

Lista de requisitos para correr os scripts:
* curl
* html-xml-utils
* wget

Em Debian/Ubuntu pode resolver-se com:
```
$ sudo apt install curl html-xml-utils wget
```
