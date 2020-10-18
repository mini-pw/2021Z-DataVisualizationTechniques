library(proton)
library(dplyr)
library(stringi)
proton()

#1

login <- filter(employees, name == 'John' & surname == 'Insecure') %>%
  select(login) %>%
  pull()

proton(action = "login", login = login)

#2


for (password in top1000passwords){
  content <- proton(action = "login", login = login, password = password)
  if (content == 'Success! User is logged in!')
    break
}

#3

pietraszko_login <- filter(employees, surname == 'Pietraszko') %>%
  select(login) %>% 
  pull()

server_ip <- filter(logs, login == pietraszko_login) %>%
  count(host, sort = TRUE) %>% 
  transmute(host = as.character(host)) %>% 
  head(1) %>%
  pull()

proton(action = "server", host = server_ip)

#4

pietraszko_password <- stri_split_fixed(bash_history, " ", simplify = TRUE) %>%
  data.frame(stringsAsFactors = FALSE) %>% 
  count(X1) %>%
  arrange(n) %>%
  head(1) %>%
  pull(X1)
  
proton(action = "login", login = pietraszko_login, password = pietraszko_password)

  
