# Zadanie 1
# Wykonać zadanie z biblioteki proton

library(proton)
library(dplyr)

proton()

employees %>%
  filter(name == "John", surname == "Insecure") %>%
  select(login) -> john_login

proton(action = "login", login=john_login)


sapply(
  top1000passwords,
       function(x) proton(action = "login",
                          login = john_login,
                          password=x)
       )

employees %>%
  filter(surname == "Pietraszko") %>%
  select(login) %>%
  as.character() -> login_celu

logs %>%
  filter(login == login_celu) %>%
  count(host, name = "liczba") %>% 
  arrange(-liczba) %>%
  head(1) %>%
  select(host) -> host_celu

proton(action = "server", host="194.29.178.16")

library(stringi)

unique(
  bash_history[!stri_detect_fixed(bash_history, " ")]
  ) -> mozliwe_hasla

stri_sort(mozliwe_hasla) -> hasla_posortowane
haslo_celu <- hasla_posortowane[1]

proton(action = "login", login=login_celu, password=haslo_celu)

rm(list = ls())