library(dplyr)
library(proton)
library(stringi)
proton()
login_Johna <- employees %>%
  filter(name == "John", surname == "Insecure") %>% 
  pull(login)
proton(action = "login", login= login_Johna)

for (variable in top1000passwords) {
  proton(action = "login", login=login_Johna, password=variable)
}

y <- employees %>%
  filter(surname == "Pietraszko") %>%
  pull(login)

logs %>%
  filter(login == y) %>%
  count(host)

#najczesciej wystepujcy host to 194.29.178.16
proton(action = "server", host= "194.29.178.16")

string <- stri_extract_first_regex(bash_history, "([^\\s]+)") %>%
  unique()

string 
#latwo zuwazyc ze haslo to "DHbb7QXppuHnaXGN"

proton(action = "login", login=y, password= "DHbb7QXppuHnaXGN")






