library(proton)
library(dplyr)
library(stringi)

proton()

# Problem 1

data("employees")
employees %>%
  filter(name == "John", surname == "Insecure")

proton(action = "login", login = "johnins")

#Problem 2

data("top1000passwords")

for (pass in top1000passwords){
  proton(action = "login", login = "johnins", password = pass )
}

#Problem 3

login_p <- employees %>%
  filter(surname == "Pietraszko") %>%
  select(login)

data("logs")

log <- logs %>%
  filter(login == login_p[1, 1]) %>%
  select(host) %>%
  group_by(host) %>%
  summarize(values = n()) %>%
  arrange(desc(values))

proton(action = "server", host = "194.29.178.16")

#Problem 4

data("bash_history")

slash <- stri_count_regex(bash_history, "\\/")
commands <- stri_count_regex(bash_history, "conf|ps|whoiam|pwd|top|mc|httpd")

bash_history[commands == 0 & slash == 0]

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN" )


  




