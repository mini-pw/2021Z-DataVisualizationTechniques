install.packages("dplyr")
install.packages("proton")
library(dplyr)
library(proton)

# Zadanie 0 
# Obejrzec: https://www.youtube.com/watch?v=LRU5TxFD394&feature=youtu.be&ab_channel=StatisticsGlobe
#Potwierdzam, obejrzane 

# Zadanie 1
# Wykonać zadanie z biblioteki proton
## Pierwsza czesc
proton()
pracownicy <- data.frame(employees)
pracownicy %>% filter(name == "John")
proton(action = "login", login = select(filter(pracownicy,name=="John",surname == "Insecure"),login))
##
##Druga czesc
hasla <- data.frame(top1000passwords)
for(x in top1000passwords){
  proton(action = "login", login = select(filter(pracownicy,name=="John",surname == "Insecure"),login),password=x)
}
##
##Trzecia czesc
logi <- data.frame(logs)
Pietraszko_login <- as.character(employees %>% filter(surname =="Pietraszko") %>% select(login))
logi %>% filter(login == Pietraszko_login)
hosts <- logi %>% filter(login == Pietraszko_login) %>% group_by(host) %>% summarize(count =n()) %>% arrange(-count)
proton(action = "server",host = as.character(hosts$host[1]))
##
##Czwarta czesc

bash_history
commands_tab <- sub(" .*", "", bash_history)
for(x in commands_tab){
  proton(action = "login", login = Pietraszko_login,password=x)
}
##
##Koniec

