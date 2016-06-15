# Pacotes -----------------------------------------------------------------
library(data.table)
library(dplyr)
library(stringr)

# Deszipar arquivos -------------------------------------------------------

arqs <- list.files("data-raw/zips/")
plyr::l_ply(arqs, function(a) {
  unzip(sprintf("data-raw/zips/%s", a), exdir = "data-raw/unzips/")
}, .progress = "text")


# Ler cada arquivo --------------------------------------------------------

arqs <- list.files("data-raw/unzips/", full.names = T)
bases <- plyr::ldply(arqs, fread, .progress = "text")


# Juntar variáveis que são as mesmas --------------------------------------

bases <- bases %>%
  mutate(
    DATA = ifelse(is.na(DATA), `#DATA_BASE`, DATA),
    COD_CONGL = ifelse(is.na(COD_CONGL), COD.CONGLOMERADO, COD_CONGL),
    NOME_CONGL = ifelse(is.na(NOME_CONGL), `NOME CONGLOMERADO`, NOME_CONGL),
    NOME_CONTA = ifelse(is.na(NOME_CONTA), `NOME CONTA`, NOME_CONTA),
    TAXONOMIA = ifelse(is.na(TAXONOMIA), ATRIBUTO, TAXONOMIA)
  ) %>%
  select(-`#DATA_BASE`, 
         -COD.CONGLOMERADO,
         -`NOME CONGLOMERADO`,
         -`NOME CONTA`,
         -ATRIBUTO
         )


# Tranformar saldo em numérico --------------------------------------------

bases <- bases %>%
  mutate(SALDO = str_replace_all(SALDO, fixed(","), ".") %>% as.numeric())


# Escrever a base
write.csv(bases, file = "data/balancetes.csv", row.names = F)
saveRDS(bases, file = "data/balancetes.rds")
