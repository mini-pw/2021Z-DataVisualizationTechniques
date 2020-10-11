library(dplyr)
library(proton)
as.factor=FALSE
proton()
LoginInsecure<-as.character(employees %>% filter(name=="John", surname=="Insecure") %>% select(login))
proton(action="login", login=LoginInsecure)
for(T in top1000passwords){
  proton(action="login", login="johnins", password=T)}
LoginPietraszko <-as.character(employees %>% filter(surname=="Pietraszko")  %>% select(login))
tmp <-logs %>% filter(login==LoginPietraszko)  %>% count(host) %>% arrange(-n)  %>% head(1)%>% select(host)
tmp <-as.character(tmp[[1,1]])
proton(action="server", host=tmp)
komendy <- strsplit(bash_history, " ")
komendy <- lapply(komendy, `[[`, 1)   
komendy <- unlist(komendy)
komendy <-unique(komendy)
proton(action='login', login=LoginPietraszko, password='DHbb7QXppuHnaXGN')
