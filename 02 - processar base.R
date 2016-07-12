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
    DATA = ifelse(is.na(DATA), as.character(`#DATA_BASE`), as.character(DATA)) %>% str_trim(),
    COD_CONGL = ifelse(is.na(COD_CONGL), as.character(COD.CONGLOMERADO), as.character(COD_CONGL)) %>% str_trim(),
    NOME_CONGL = ifelse(is.na(NOME_CONGL), as.character(`NOME CONGLOMERADO`), as.character(NOME_CONGL)) %>% str_trim(),
    NOME_CONTA = ifelse(is.na(NOME_CONTA), as.character(`NOME CONTA`), as.character(NOME_CONTA)) %>% str_trim(),
    TAXONOMIA = ifelse(is.na(TAXONOMIA), as.character(ATRIBUTO), as.character(TAXONOMIA)) %>% str_trim()
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

# Escrever a base ---------------------------------------------------------

write.csv(bases, file = "data/balancetes.csv", row.names = F)
saveRDS(bases, file = "data/balancetes.rds")
zip(zipfile = "data/balancetes.zip", files = "data/balancetes.csv")





