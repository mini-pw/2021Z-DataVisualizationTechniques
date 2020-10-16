library(dplyr)
library(proton)


proton()

employees %>%
  filter(surname == "Insecure") %>%
  head

proton(action = "login", login = "johnins")

for(haslo in top1000passwords) proton(action = "login", login = "johnins", password=haslo)

employees %>%
  filter(surname == "Pietraszko") %>%
  head

logs %>%
  filter(login == "slap") %>%
  count(host) %>%
  arrange(-n)

proton(action = "server", host = "194.29.178.16")

bash_copy <- bash_history
bash_copy <- sub(" .*", "", bash_copy)

bash_copy[order(-nchar(bash_copy))] %>%
  head

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")
