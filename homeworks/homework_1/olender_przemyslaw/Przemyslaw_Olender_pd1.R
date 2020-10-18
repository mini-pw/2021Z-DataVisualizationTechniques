#install.packages("proton")

library(dplyr)
library(proton)
library(stringi)

proton()

head(employees)
filter(employees, name == "John", surname == "Insecure") %>% 
  select(login) #johnins

proton(action = "login", login = "johnins")

head(top1000passwords)

for(pass in top1000passwords){
  answear <- proton(action = "login", login = "johnins", password = pass)
  if(answear == "Succes! User is logged in!") break
} #freepass

head(logs)
filter(employees, surname == "Pietraszko") %>% 
  select(login) #slap

filter(logs, login == "slap") %>% 
  count(host) %>% 
    arrange(-n) #194.29.178.16

proton(action = "server", host = "194.29.178.16")

head(bash_history)
slap_pass <- as.data.frame(stri_extract_first_regex(bash_history, "\\w*"))
colnames(slap_pass) <- "pass"
slap_pass <- count(slap_pass, pass) %>% arrange(n)

slap_pass[1,] #DHbb7QXppuHnaXGN

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")