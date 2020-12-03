library(dplyr)
library(ggplot2)
library(tidyr)

read.csv("dane/raw/covid_powiaty_raw.csv", fileEncoding = "UTF-8") -> raw

to_date <- function(v) {
  as.Date(v, "X%d.%m")
}


raw %>%
  filter(Kod %% 100000 == 0) %>%
  mutate_all(list(~na_if(.,""))) %>%
  mutate_at(vars(matches("X")), as.character) %>% # gupie factory
  mutate_at(vars(matches("X")), as.integer) %>% 
  pivot_longer(cols = X04.03:X20.11, names_to = "Data", values_to = "Liczba_chorych") %>%
  mutate_at("Data", to_date) ->
  wojewodztwa

raw %>%
  filter(Kod %% 100000 != 0) %>%
  mutate_all(list(~na_if(.,""))) %>%
  mutate_at(vars(matches("X")), as.character) %>%
  mutate_at(vars(matches("X")), as.integer) %>% 
  pivot_longer(cols = X04.03:X20.11, names_to = "Data", values_to = "Liczba_chorych") %>%
  mutate_at("Data", to_date) ->
  powiaty

# sanity check
ggplot(powiaty %>% filter(Nazwa == "Powiat m. st. Warszawa")) +
  geom_col(aes(x = Data, y = Liczba_chorych))

ggplot(wojewodztwa %>% filter(Nazwa == "POLSKA")) +
  geom_col(aes(x = Data, y = Liczba_chorych))
