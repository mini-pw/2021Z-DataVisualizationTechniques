install.packages("proton")
library("proton")
library(dplyr)
proton()

employees

loginJohn <- employees %>% filter(name == "John" & surname == "Insecure") %>% select(login)
loginJohn

proton(action = "login", login=loginJohn)

top1000passwords

for (element in top1000passwords){
  proton(action = "login", login=loginJohn, password=element)
}

loginSlawomir <- employees %>% filter(surname == "Pietraszko") %>% select(login)
loginSlawomir <- paste( unlist(loginSlawomir), collapse='')


serverPietraszko <- logs %>% filter(login == loginSlawomir )
x <- serverPietraszko %>%  count(host) %>% arrange(desc(n)) %>% select(host)
serverPietraszko <- x[1,]
serverPietraszko <-paste( unlist(serverPietraszko), collapse='')

proton(action = "server", host=serverPietraszko)

password <- bash_history[!grepl(" ", bash_history)]
password %>% data.frame() %>% distinct()

proton(action = "login", login=loginSlawomir, password = "DHbb7QXppuHnaXGN")
