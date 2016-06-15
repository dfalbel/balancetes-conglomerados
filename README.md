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

