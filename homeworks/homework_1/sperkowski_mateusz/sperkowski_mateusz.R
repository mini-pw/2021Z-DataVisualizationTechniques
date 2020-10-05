library(proton)
library(dplyr)
library(stringr)
proton()

employees %>% filter(name == "John", surname == "Insecure")

proton(action = "login", login="johnins")

top1000passwords
for(pass in top1000passwords){
  proton(action = "login", login="johnins", password = pass)
}

logs %>% head()
employees %>% filter(surname == "Pietraszko")

Pietraszko <- logs %>% filter(login == "slap")
Pietraszko %>% count(host)

proton(action = "server", host="194.29.178.16")

pass <- bash_history[!str_detect(bash_history, " ")]

pass %>% data.frame() %>% distinct()

proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")
