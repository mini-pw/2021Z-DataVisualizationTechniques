library(dplyr)
library(proton)
proton()

#Problem 1
login_john_insecure <-
  employees %>%
  filter(name == "John", surname == "Insecure")
login_john_insecure <- login_john_insecure$login

proton(action = "login", login=login_john_insecure)

#Problem 2
for(possible_password in top1000passwords){
  answer <- proton(action = "login", loginb = login_john_insecure, password = possible_password)
  if (answer == 'Success! User is logged in!'){
    password_john_insecure <- possible_password
    break
  }
}

proton(action = "login", loginb = login_john_insecure, password = password_john_insecure)

#Problem 3
login_pietraszko <- 
  employees %>% 
  filter(surname=="Pietraszko")
login_pietraszko <- login_pietraszko$login

most_common_host <- 
  logs %>% 
  filter(login == login_pietraszko) %>%
  count(host) %>%
  arrange(desc(n)) %>%
  head(1)
most_common_host <- toString(most_common_host$host)
proton(action = "server", host = most_common_host)


#Problem 4
library(stringi)

possible_password2 <- stri_extract_first_regex(bash_history, '^[^ ]+')
possible_password2 <- unique(possible_password2)
possible_password2
# przegladam recznie
password_pietraszko <- 'DHbb7QXppuHnaXGN'
proton(action = "login", login = login_pietraszko, password = password_pietraszko)
