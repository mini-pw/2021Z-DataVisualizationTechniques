library(dplyr)
emp<-proton::employees

emp %>% filter(name=="John", surname=="Insecure") %>% select(login)
#johnins

#proton(action = "login", login="johnins")

for( pass in top1000passwords){
  rep <- proton(action = "login", login="johnins", password=pass)
  if(rep=="Success! User is logged in!"){
    ans <- pass
    break
  }
}
#q1w2e3r4t5

#proton(action = "login", login="johnins", password="q1w2e3r4t5")

emp %>% filter(surname=="Pietraszko") %>% select(login)
#slap

logs %>% filter(login=="slap") %>% count(host)
#194.29.178.16

#proton(action = "server", host="194.29.178.16")

commands<-c("")
for(com in bash_history){
  com<-strsplit(com, " ")[[1]][1]
  if(! com %in% commands){
    commands<- c(commands,com)
  }
}
#DHbb7QXppuHnaXGN

#proton(action = "login", login="slap", password="DHbb7QXppuHnaXGN")
