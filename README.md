balancetes-conglomerados
================================

Esse repositório contém algum arquivos disponíveis [nesta página](http://www4.bcb.gov.br/fis/cosif/balancetes.asp)
do site do Banco Central do Brasil.

A base final com os dados já processados é o arquivo: `data/balancetes.rds`.
Ele está no formato `rds` por questão de tamanho, o Github não aceita arquivos
maiores de 100MB. 

Para lê-lo basta usar no R o comando:

```
base <- readRDS("data/balancetes.rds")
```

### Descrição dos campos

* Data:	Data-base a que se refere a informação.
* CNPJ:	Número de identificação da instituição no Cadastro Nacional de Pessoas Jurídicas, mantido pela Secretaria da Receita Federal do Brasil.
Nome da Instituição:	Nome da instituição constante do Sistema de Informações sobre Entidades de Interesse do Banco Central (Unicad).
* Atributo/Taxonomia:	Código que identifica o tipo de instituição no Sistema de Informações sobre Entidades de Interesse do Banco Central (Unicad).
Documento:	Código do documento a que se refere a informação, de acordo com o Catálogo de Documentos (Cadoc) (a estrutura do documento pode ser verificada no link http://www.bcb.gov.br/?COSIF, capítulo 3 - Documentos.
* Conta:	Código da conta a que se refere o saldo, conforme codificação estabelecida pelo Plano Contábil das Instituições do Sistema Financeiro Nacional (Cosif) (informações sobre o funcionamento das contas pode ser obtida no link http://www.bcb.gov.br/?COSIF, capítulo 2 - Elenco de Contas).
* Nome da Conta:	Descrição do nome da conta, conforme estabelecido no Cosif.
* Saldo:	Saldo informado pelas instituições no documento, com 2 casas decimais (dependendo do aplicativo utilizado para ler o arquivo poderá ser necessário formatar o campo saldo).


O saldo é apresentado nas seguintes moedas, de acordo com a data-base:

* Real (R$)	: a partir de 07/1994
* Cruzeiro Real (CR$) : de 08/1993 a 06/1994
* Cruzeiro (Cr$)	: de 03/1990 a 07/1993
* Cruzado Novo (NCz$) : de 01/1989 a 02/1990
* Cruzado (Cz$)	: até 12/1988