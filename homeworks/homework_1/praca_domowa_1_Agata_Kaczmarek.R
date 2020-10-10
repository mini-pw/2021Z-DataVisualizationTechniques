library(dplyr)
library(proton)
library(stringr)

proton()

#Problem 1 - finding login of John Insecure

login_John_Insecure <- employees %>% 
  filter (name == "John", surname == "Insecure") %>% 
  select (login)
login_John_Insecure <-login_John_Insecure[1,1]
proton(action = "login", login =login_John_Insecure)

#Problem  2 - finding password of John Insecure

top1000passwords[1:1000]
n<-c(1:1000)
for (i in n){
  proton(action = "login", login =login_John_Insecure, password=top1000passwords[i])}

#Problem 3 - finding Pietraszko login

login_Pietraszko <- employees %>% 
  filter (surname == "Pietraszko") %>% 
  select (login)
login_Pietraszko<-login_Pietraszko[1,1]
servers_Pietraszko_all <- logs %>% 
  filter (login ==login_Pietraszko) %>% 
  count(host) %>% 
  arrange (desc(n))
servers_Pietraszko_all <- servers_Pietraszko_all %>% select (host)
server_name <- servers_Pietraszko_all[1,]
server_name <- as.vector(server_name)

proton(action = "server", host=server_name)

#Problem 4 - finding Pietraszko password

bash_history <- as.data.frame(bash_history)
first_names <- word(bash_history$bash_history, 1)
first_names<- as.data.frame(first_names)
first_names <- first_names %>% count(first_names)
first_names <- first_names %>% filter(n == 1)
password <- as.vector(first_names[1][1])
password
