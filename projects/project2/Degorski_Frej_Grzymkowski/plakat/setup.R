# Plik z importem i libami, odpalić na nowym envie

library(dplyr)
library(tidyr)
library(ggplot2)

# pomocnicza funkcja do ładowania danych
load_twd <- function(path_to_file) {
  as.tbl(
    read.csv(path_to_file, stringsAsFactors = FALSE, encoding = "UTF-8")
  )
}

dzienne_przypadki <- load_twd("dane/dzienne_przypadki.csv") %>% mutate_at("Data", as.Date)

powiaty <- load_twd("dane/powiaty_chorzy.csv") %>% mutate_at("Data", as.Date)
powiaty_pop_id <- load_twd("dane/powiaty_pop_id.csv") 
syt_epidemiczna <- load_twd("dane/epidemiczna.csv") %>% mutate_at("data", as.Date)
testy_polska <- load_twd("dane/testy_polska.csv") %>% mutate_at("data", as.Date)

aktywne <- load_twd("dane/aktywne_po_dacie.csv") %>% mutate_at("Data", as.Date)

# funkcje pomocnicze do ogarniania danych

polski_do_R <- function(var) { 
  var %>% 
    as.character() %>%
    # stringr::str_replace(space(), "")%>% 
    stringi::stri_replace_all_charclass("\\p{WHITE_SPACE}", "") %>%
    stringr::str_replace(",", ".") %>%
    as.numeric()
}

polski_procent_do_R <- function(var) { 
  var %>% 
    as.character() %>%
    stringr::str_replace("%", "")%>% 
    stringi::stri_replace_all_charclass("\\p{WHITE_SPACE}", "") %>%
    stringr::str_replace(",", ".") %>%
    as.numeric() / 100
}