install.packages("dplyr")
install.packages("PogromcyDanych")

library(dplyr)
library(PogromcyDanych)
library(tidyr)

# Zadanie 1
# Wykonać zadanie z biblioteki proton
library(proton)

proton()
#Problem 1
help<-employees%>%
  filter(employees$name=="John" & employees$surname=="Insecure")

logins<-help$login

proton(action = "login", login=help$login)
#Problem 2
for(k in 1:1000){
  proton(action = "login", login=help$login, password=top1000passwords[k])== "`Success! User is logged in!`"
}
#Problem 3
logs
logins

#Znajdujemy login Pana Pietraszko
help<-employees%>%
  filter(employees$surname=="Pietraszko")
loginss<-help$login
loginss
#Znajdujemy stację z której znaleziony wcześniej login był używany najczęściej
help<- logs %>%
  filter(login==loginss)%>%
  count(host)%>%
  arrange(n)%>%
  tail(1) %>%
  pull(var=1)
help
#Szukana stacja
droplevels(help)
proton(action="server", host="194.29.178.16")
#Problem 4
?table
?strsplit
#Za pomocą funkcji table wyszukujemy ilosc wystepujacych w bash_history komend i wartości znajdujących się po nich.
table(unlist(strsplit(bash_history," ")))
#Zauważamy, że jedna dana wystąpiła jedynie raz i w dodatku wygląda jak skomplikowane hasło, stąd próbujemy się nią zalogować
proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")
  