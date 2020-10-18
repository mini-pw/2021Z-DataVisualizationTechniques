library(proton)
proton()

# 1 
employees -> x
proton(action = "login", login="johnins")

#2
top1000passwords -> passwords
for(i in 1:1000){
  reply=proton(action ="login", login="johnins", password=passwords[i] )
  if (reply=="`Success! User is logged in!`"){
    break
  }
}
passwords[i]

#3
library(dplyr)
dplyr::count(logs,login,host) %>% filter(login=="slap") %>% arrange(-n) ->tab
tab
proton(action = "server", host="194.29.178.16")


#4
data("bash_history")
bash_history

grep(pattern = " ",x=bash_history,value = TRUE,invert = TRUE) %>% unique()
proton(action="login",login="slap",password="DHbb7QXppuHnaXGN")
