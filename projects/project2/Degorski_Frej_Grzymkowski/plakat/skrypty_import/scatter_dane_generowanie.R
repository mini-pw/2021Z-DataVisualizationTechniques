library(dplyr)
library(ggplot2)

# potrzebne tylko raz do wygenerowania danych

powiaty_pop_id <- read.csv('dane/powiaty_pop_id.csv', fileEncoding = "UTF-8")

powiaty %>%
  filter(Data == as.Date("2020-11-15")) %>%
  na.omit() %>%
  left_join(powiaty_pop_id, by="Kod") %>%
  mutate(procent_chorych = (Liczba_chorych/Liczba_ludnosci)*1000) %>%
  select(Kod, Nazwa = Nazwa.x, Gestosc_zaludnienia, Procent_chorych = procent_chorych) -> scatter_dane

woj_kody <- filter(wojewodztwa, Data == "2020-11-15")
woj_kody["woj"] <- woj_kody["Kod"] %/% 100000
woj_kody <- select(woj_kody, woj, Wojewodztwo = Nazwa)

scatter_dane["woj"] = scatter_dane["Kod"] %/% 100000
scatter_dane <- left_join(scatter_dane, woj_kody)

write.csv(scatter_dane, 'dane/scatter_dane.csv', fileEncoding = "UTF-8", row.names = FALSE)