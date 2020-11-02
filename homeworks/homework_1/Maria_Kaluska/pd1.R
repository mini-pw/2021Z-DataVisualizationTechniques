library(dplyr)
library(proton)

  
proton()
head(employees)

John_Insecure_login <- filter(employees, name=="John", surname=="Insecure") %>%
  select(login)
proton(action="login", login=John_Insecure_login)

check_password <- function(password) {
  if (proton(action="login", login=John_Insecure_login, password=password) == "Success! User is logged in!") return(TRUE)
  else return(FALSE)
}

passwords <- sapply(top1000passwords, check_password)
correct_password <- top1000passwords[passwords]

Pietraszko_login <- filter(employees, surname=="Pietraszko") %>%
    select(login)

pietraszko_logs <- filter(logs, login==Pietraszko_login[1, "login"])

pietraszko_host <- pietraszko_logs %>%
  count(host) %>%
  filter(n==max(n)) %>%
  select(host)

proton(action = "server", host=as.vector(pietraszko_host[1,1]))

data.frame(history=bash_history) %>%
  mutate(first_word=sapply(strsplit(history," "), `[`, 1)) %>%
  filter(nchar(first_word)>=6, !(first_word %in% c("mcedit", "whoiam", "service"))) %>%
  head()

proton(action="login", login=Pietraszko_login[1, "login"], password="DHbb7QXppuHnaXGN")

