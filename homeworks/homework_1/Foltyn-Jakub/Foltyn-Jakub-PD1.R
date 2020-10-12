library(proton)
library(dplyr)
library(tidyr)

proton()

##TASK 1
data("employees")

employees %>% filter(name == "John", surname== "Insecure")

proton(action = "login", login= "johnins")

##TASK 2
data("top1000passwords")

x <- seq(1,1000)
for(val in x){
  proton(action = "login", login= "johnins", password = top1000passwords[val])
}
##TASK 3
data("logs")

employees %>% filter(surname=="Pietraszko")

##login to slap

logs %>% filter(login=="slap") %>% count(host) %>% arrange(-n)

proton(action = "server", host="194.29.178.16")

##TASK 4
data("bash_history")

as.data.frame(bash_history) %>% 
  separate(bash_history, " ", into = c("commands","files")) %>% 
  group_by(commands) %>% summarize()

proton(action = "login", login= "slap", password = "DHbb7QXppuHnaXGN")
