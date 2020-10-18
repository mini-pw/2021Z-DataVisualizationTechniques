# Zadanie 1
# Wykonać zadanie z biblioteki proton
library(proton)
library(dplyr)
proton()
login <- employees %>%
  filter(name == "John", surname == "Insecure") %>%
  select(login)
proton(action = "login", login = login)

x <- proton(action = "login", login = login, password = top1000passwords[1])
i <- 1
while (x != "Success! User is logged in!")
{
  i = i + 1
  x <- proton(action = "login", login = login, password = top1000passwords[i])
}

pietraszko_login <- employees %>%
  filter(surname == "Pietraszko") %>%
  select(login) %>%
  pull()
pietraszko_server <- filter(logs, login == pietraszko_login) %>%
  count(host) %>%
  arrange(-n) %>%
  head(1) %>%
  pull(host) %>%
  toString()
proton(action = "server", host = pietraszko_server)

passwords <- strsplit(bash_history, " ") %>%
  lapply(function(x) x[1]) %>%
  unlist()
x <- proton(action = "login", login = pietraszko_login, password = passwords[1])
i <- 1
while (x != "Success! User is logged in!")
{
  i = i + 1
  x <- proton(action = "login", login = pietraszko_login, password = passwords[i])
}