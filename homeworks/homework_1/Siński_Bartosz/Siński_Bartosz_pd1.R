library(dplyr)
install.packages("proton")
library(proton)
library(stringi)
proton()

johns_login <- filter(employees,name == "John", surname == "Insecure") %>%
  select(login) %>% toString()
proton(action = "login",login = johns_login)


haslo <- ""
for (pass in top1000passwords) {
  if(proton(action = "login", login = johns_login[1], password = pass) == "Success! User is logged in!"){
    haslo <- pass
    break
  }
}
proton(action = "login", login = johns_login[1], password = haslo)


pietr_login <- filter(employees, name == "Slawomir", surname == "Pietraszko") %>%
  select(login) %>% toString()
pietr_login
pietr_computer <- filter(logs, login == pietr_login) %>% count(host) %>% arrange(-n) %>% select(host)
pietr_computer <- pietr_computer[1,]
pietr_computer  
proton(action = "server",host = "194.29.178.16")

commands <- stri_extract_first_regex(bash_history,"[^\\s]*")
commands <- unique(commands)
commands
proton(action = "login", login = pietr_login, password = "DHbb7QXppuHnaXGN")
