# Parâmetros --------------------------------------------------------------
url <- "http://www4.bcb.gov.br/fis/cosif/cont/balan/conglomerados/"
anos <- 2000:2010
meses <- 1:12


# Download ----------------------------------------------------------------

for (ano in anos) {
  for (mes in meses) {
    download.file(url = sprintf("%s%d%02dCONGLOMERADOS.zip", url, ano, mes), 
                  destfile = sprintf("data-raw/zips/%d%02dCONGLOMERADOS.zip", ano, mes)
    )
    Sys.sleep(0.7)
  }
}


# Verificar que tudo foi baixado ------------------------------------------

length(anos)*length(meses) == length(list.files("data-raw/zips/"))
