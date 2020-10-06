library(dplyr)
library(proton)
library(stringi)
proton()

# Problem 1.

log <- employees %>% 
  filter(name == "John" & surname == "Insecure") %>% 
  select(login)

log <- as.character(log)
proton(action = "login", login=log)

# Problem 2.

for (i in top1000passwords) {
  proton(action = "login", login = log, password=i)
}

# Problem 3.

log2 <- employees %>% 
  filter(surname == "Pietraszko") %>% 
  select(login)
log2 <- as.character(log2)

host2 <- logs %>% 
  filter(login == log2) %>%
  select(host) %>% 
  group_by(host) %>% 
  summarise(liczba = n()) %>% 
  arrange(-liczba) %>% 
  ungroup() %>% 
  select(host) %>% 
  sapply(as.vector)

proton(action = "server", host=as.vector(host2[1,1]))

# Problem 4.

a <- as.vector(stri_extract_all_regex(bash_history, "^[^ ]+$"))
a <- a[!is.na(a)]
unlist(unique(a))

## [1] "pwd"              "ps"               "whoiam"
## [4] "top"              "mc"               "DHbb7QXppuHnaXGN"     Jest hasło!