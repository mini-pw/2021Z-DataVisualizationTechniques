library(proton)
library(dplyr)

proton()



#Problem 1
employees %>% filter(name == "John", surname == "Insecure")

l <-
  employees %>% filter(name == "John", surname == "Insecure") %>% select(login)
proton(action = "login", login = l)






#Problem 2

for (pass in top1000passwords)
{
  proton(action = "login",
         login = "johnins",
         password = pass)
}






#Problem 3

employees %>% filter(surname == "Pietraszko")
l <- employees %>% filter(surname == "Pietraszko") %>% pull(login)

logs %>% filter (login == l) %>% count(host) %>% arrange(desc(n))
ip <-
  logs %>% filter (login == l) %>% count(host) %>% arrange(desc(n)) %>% pull(host)
ip <- as.character(ip[1])

proton(action = "server", host = ip)




#Problem 4

bash_history[!grepl(" ", bash_history)] %>% unique()


proton(action = "login",
       login = "slap",
       password = "DHbb7QXppuHnaXGN")
