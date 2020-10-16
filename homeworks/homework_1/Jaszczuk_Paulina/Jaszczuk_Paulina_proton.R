library(proton)
library(dplyr)

proton()
head(employees)

John_login <- employees %>%  filter(name == "John", surname == "Insecure") %>% select(login)
proton(action = "login", login = John_login)

head(top1000passwords)

for (i in top1000passwords){
  x <- proton(action = "login", login=John_login, password=i)
  if(length(grep(pattern = "Success", x = x)) == 1){
    print(i)
  }
}

head(logs)
Pietraszko_login <- employees %>% 
  filter(surname == "Pietraszko") %>% 
  select(login) %>% 
  as.character()

Pietraszko_logs <-  filter(logs, login == Pietraszko_login) %>% 
  group_by(host) %>% 
  summarise(count = n()) %>% 
  arrange(-count) %>% 
  select(host) %>% 
  slice(1)

proton(action = "server", host="194.29.178.16")
head(bash_history)
unique(grep(pattern = " ", x = bash_history, value = TRUE, invert = TRUE))
"DHbb7QXppuHnaXGN"
proton(action = "login", login="slap", password="DHbb7QXppuHnaXGN")
