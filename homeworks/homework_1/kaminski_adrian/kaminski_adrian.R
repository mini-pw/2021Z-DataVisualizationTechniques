# Zadanie 1
# Wykonać zadanie z biblioteki proton

library(proton)
library(dplyr)
library(stringi)

### 1

proton()

employees %>%
  filter(name == "John", surname == "Insecure") %>%
  select(login) -> john_login

### 2

proton(action = "login", login=john_login)


# sapply(
#   top1000passwords,
#        function(x) proton(action = "login",
#                           login = john_login,
#                           password=x)
#        ) # tez dziala tylko sprawdza wszystkie hasla

for (password in top1000passwords) {
  if (proton(action ="login", login=john_login, password=password) == "Success! User is logged in!") {
    break() 
  }
}

### 3

# proton(action ="login", login=john_login, password=password) # wykonuje sie już w if (warunek)

employees %>%
  filter(surname == "Pietraszko") %>%
  select(login) %>%
  as.character() -> login_celu

logs %>%
  filter(login == login_celu) %>%
  count(host, name = "liczba") %>% 
  arrange(-liczba) %>%
  head(1) %>%
  .$host %>%
  as.character() -> host_celu

### 4

proton(action = "server", host=host_celu)

unique(
  bash_history[!stri_detect_fixed(bash_history, " ")]
  ) -> mozliwe_hasla

stri_sort(mozliwe_hasla) -> hasla_posortowane # przydatne w przypadku wiekszej ilosci mozliwych hasel
haslo_celu <- hasla_posortowane[1]

proton(action = "login", login=login_celu, password=haslo_celu)

rm(list = ls())
