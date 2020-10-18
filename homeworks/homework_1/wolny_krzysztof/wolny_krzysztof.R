library("dplyr")
library("proton")
library(stringi)
proton()

employees%>%
  filter(name == "John", surname == "Insecure")

proton(action = "login", login = "johnins")

for (password in top1000passwords) {
  proton(action = "login", 
         login = "johnins", 
         password = password)
}

employees%>%
  filter(surname == "Pietraszko")

logs %>%
  filter(login == "slap")%>%
  group_by(host)%>%
  summarise(n = n())%>%
  arrange(desc(n))

proton(action = "server", host = "194.29.178.16")

# sprawdzam, które z polecen nie maja spacji
bash_history[!stri_detect_fixed(bash_history, " ")]

# Hasło to będzie "DHbb7QXppuHnaXGN"
proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")