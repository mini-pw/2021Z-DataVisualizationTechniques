library(dplyr)
library(proton)
proton()
# Pierwszwe
employees %>%
  filter(name == "John", surname == "Insecure") %>%
  select(login)
proton(action = "login", login="johnins")
# Drugie
i = 1
while(i<= 1000){
  proton(action = "login", login="johnins", password = top1000passwords[i])
  i = i+1
}
# Trzecie
employees %>%
  filter(surname == "Pietraszko") %>%
  select(login)
logs %>% filter(login == "slap") %>% count(host, sort = TRUE)
proton(action = "server", host="194.29.178.16")
#Czwarte
gsub(" .*", "", bash_history) %>% data.frame() %>% distinct()
proton(action = "login", login="slap", password="DHbb7QXppuHnaXGN")

