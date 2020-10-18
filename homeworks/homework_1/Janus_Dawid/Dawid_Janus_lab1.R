library(proton)
library(dplyr)
library(stringr)

#Problem nr 1
proton()
employees %>% filter(name == "John", surname == "Insecure")
proton(action = "login", login = "johnins")

#Problem nr 2

for (liczba in 1:1000) {
  proton(action = "login",
         login = "johnins",
         password = top1000passwords[liczba])
  
}

#Problem nr 3
employees %>% filter(surname == "Pietraszko")
logs %>% filter(login == "slap") %>%  group_by(host) %>% count() %>% arrange(-n)
proton(action = "server", host = "194.29.178.16")


#Problem nr 4
sub(" .*", "", bash_history) %>% data_frame()  %>%
  rename(name = ".") %>% group_by(name) %>%
  count() %>% arrange(n)

proton(action = "login",
       login = "slap",
       password = "DHbb7QXppuHnaXGN")
