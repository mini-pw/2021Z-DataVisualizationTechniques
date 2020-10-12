library(proton)
library(dplyr)
proton()

#task1

log <- employees %>% filter(name == "John", surname == "Insecure") %>% select(login) %>% .$login
proton(action = "login", login=log)

#task2
for (v in unique(top1000passwords)){
  proton(action = "login", login=log, password=v)
}

#task3
log1 <- employees %>% filter(surname == "Pietraszko") %>% select(login) %>% .$login
host1 <-  logs %>% filter(login==log1) %>% count(host) %>% arrange(desc(n)) %>% head(1) %>% pull(host)
proton(action ="server", host="194.29.178.16")

#task4

passw <- sub(" .*", "", bash_history) %>% unique() %>% .[15]
proton(action="login", login=log1, password=passw)
