library(dplyr)
library(tidyr)
library(proton)

proton()

login <- employees %>%
  filter(name == "John", surname == "Insecure")
login <- as.character(login[1, "login"])
proton(action = "login", login = login)

password <- top1000passwords[mapply(function(X) {proton(action = "login", login = login, password=X) != "Password or login is incorrect"}, top1000passwords)]

pieterLogin <- employees %>%
   filter(surname == "Pietraszko")
pieterLogin <- pieterLogin[1, "login"]
ip <- logs %>%
    filter(login == pieterLogin) %>%
    count(host) %>%
    arrange(desc(n))
ip <- as.character(as.character(ip[1, "host"]))
proton(action = "server", host = ip)

pieterPassword <- data.frame(command = bash_history) %>%
  separate(command, c("com"), " ", extra="drop") %>%
  count(com) %>%
  arrange(n)
pieterPassword <- as.character(pieterPassword[1, "com"])
proton(action = "login", login = pieterLogin, password = pieterPassword)
