library(dplyr)
library(proton)
library(stringr)
proton()

employees %>% 
  filter(name == "John") %>%
  filter(surname == "Insecure")

proton(action = "login", login = "johnins")

top1000passwords %>% head()
for (password in top1000passwords) {
  proton(action = "login", login = "johnins", password = password)
}

logs %>% head()
employees %>% 
  filter(surname == "Pietraszko")

logs %>%
  filter(login == "slap") %>%
  count(host) %>%
  arrange(-n) %>%
  top_n(1)

proton(action = "server", host = "194.29.178.16")

bash_history %>% head()
pom <- bash_history[!str_detect(bash_history, " ")] %>%
  data.frame() 

colnames(pom) <- c("command")
pom %>% 
  count(command) %>%
  arrange(n)

proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")

