install.packages("proton")
library(proton)

proton()

#-----

employees %>% filter(name == 'John', surname == 'Insecure')
proton(action = "login", login = "johnins")

#-----

i <- 1
while (wynik == 'Password or login is incorrect') { 
  wynik <- proton(action = "login", login = "johnins", password = top1000passwords[i])
  i <- i + 1
}

#-----

employees %>% filter( surname == 'Pietraszko')
logs %>% filter(login == "slap") %>% count(host)

proton(action = 'server', host = '194.29.178.16', hint = TRUE)

#----

haslo <- unique(sub(" .*", "", bash_history))
haslo

proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")



