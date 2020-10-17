install.packages("dplyr")
install.packages("proton")

library(dplyr)
library(proton)

proton()

employees

login <- employees %>%
  filter(surname == "Insecure") %>%
  select(login)

# Login to 'johnins'

proton(action = "login", login=login)

# Dobry login, czas na has³o

for(i in top1000passwords) {
   proton(action = "login", login= "johnins", password= i) }

# Problem 3
# Potrzeba loginu Pietraszki:

loginPietr<- employees %>%
  filter(surname == "Pietraszko") %>%
  select(login)

# Login to "slap"
# Teraz sprawdzimy na jaki serwer najwiecej sie loguje:

(logs %>%
  filter(login == loginPietr[1,]) %>%
  group_by(host) %>%
  count() %>%
  arrange(-n)) -> servers

as.character(data.frame(select(servers))[1,])-> host
proton(action = "server", host=host)

# Problem 4

history <- bash_history[-grep(" ",bash_history)]
sus <- data.frame(history) %>%
  distinct()

sus # Bo s¹ suspicious

# 'DHbb7QXppuHnaXGN' wygrywa ten konkurs

proton(action = "login", login= loginPietr, password='DHbb7QXppuHnaXGN' )

# Voila
