library(proton)
library(dplyr)
library(stringr)

#Zadanie 1
proton()
l<-employees%>%
  filter(name=="John",surname=="Insecure")%>%
  select(login)
log<-l[1]
proton(action="login", login=log)

#Zadanie 2
for(i in top1000passwords){
  if(proton(action="login", login=log, password=i)=="Success! User is logged in!"){
    password<-i
    print(i)
  }
}

#Zadanie 3
lp<-employees%>%
  filter(surname=="Pietraszko")%>%
  select(login)
h<-logs%>%
  filter(login==lp[1,1])%>%
  count(host)
h<-filter(h,h[,2]==max(h[,2]))
h[1]
proton(action="server", host="194.29.178.16")

#Zadanie 4
password<-bash_history[!str_detect(bash_history,"[:space:]")]
data.frame(password)%>%
  count(password)%>%
  filter(n==1)%>%
  select(password)
proton(action="login",login=lp,password="DHbb7QXppuHnaXGN")
