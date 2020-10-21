library(proton)
library(dplyr)
library(stringr)

proton()

# 1
employees %>% filter(name == "John", surname == "Insecure") %>% select(login)
proton(action ="login", login ="johnins")

# 2
for (pass in top1000passwords) {
  proton(action = "login", login="johnins", password=pass)
}

# 3
employees %>% filter(surname == "Pietraszko")

logs %>% filter(login == "slap") %>% count(host) 

proton(action = "server", host="194.29.178.16")

# 4
bash_history[!str_detect(bash_history, " ")] %>% data.frame() %>% distinct()

proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")

