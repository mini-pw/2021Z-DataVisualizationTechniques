library(proton) 
library(dplyr) # wczytujemy biblioteki

proton()

data("employees")

employees %>%
  filter(name == "John", surname == "Insecure") # szukamy loginu Johna filtrujac dane pracownikow

proton(action = "login", login = "johnins")

data("top1000passwords")

for (pass in top1000passwords) {
  proton(action = "login", login = "johnins", password = pass)
} # sprawdzamy 1000 najpopularniejszych hasel w petli

data("logs")

# znajdujemy login Pietraszko
employees %>%
  filter(surname == "Pietraszko") #slap

logs %>%
  filter(login == "slap") %>%
  count(host) %>%
  arrange(-n) # 194.29.178.16

proton(action = "server", host="194.29.178.16")

data("bash_history")

library(stringi) # wczytujemy biblioteke stringi w celu przeszukania napisow

# sprawdzamy wszystkie wpisywane komendy
commands <- unique(stri_extract_first_regex(bash_history, "(^.*?(?=[ ]))|(^[\\S]+$)")) 
commands

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")
