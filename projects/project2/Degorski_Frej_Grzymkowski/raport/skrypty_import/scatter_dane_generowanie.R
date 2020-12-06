library(dplyr)
library(ggplot2)

# potrzebne tylko raz do wygenerowania danych

powiaty_pop_id <- read.csv('dane/powiaty_pop_id.csv', fileEncoding = "UTF-8")

powiaty %>%
  filter(Data == as.Date("2020-11-15")) %>%
  na.omit() %>%
  left_join(powiaty_pop_id, by="Kod") %>%
  mutate(procent_chorych = (Liczba_chorych/Liczba_ludnosci)) %>%
  select(Kod, Nazwa = Nazwa.x, Gestosc_zaludnienia, Procent_chorych = procent_chorych) -> scatter_dane

write.csv(scatter_dane, 'dane/scatter_dane.csv', fileEncoding = "UTF-8", row.names = FALSE)