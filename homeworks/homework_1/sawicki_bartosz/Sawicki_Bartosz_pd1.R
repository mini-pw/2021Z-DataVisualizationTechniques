library(proton)
library(dplyr)
library(tidyr)
library(stringi)
proton()

employees %>%
  filter(surname == "Insecure")

proton(action="login", login = "johnins")

for (pass in top1000passwords){
  proton(action = "login", login = "johnins", password = pass)
}

head(logs)

pietraszko_logs <- logs %>% filter(
  login == (employees %>% filter(surname == "Pietraszko"))$login) %>%
  group_by(host) %>%
  count() %>%
  arrange(-n) %>%
  head(1)

proton(action = "server", host = as.character(pietraszko_logs$host[1]))

head(bash_history)

unique(stri_extract_first_regex(bash_history, c('\\w+')))

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")


