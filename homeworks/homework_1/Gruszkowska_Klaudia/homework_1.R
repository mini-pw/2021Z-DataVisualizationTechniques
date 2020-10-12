#install.packages("PogromcyDanych")
#install.packages("proton")
#install.packages("dplyr")
library(proton)
library(dplyr)

proton()

#Problem_1

data("employees")

login<-employees %>%
  filter(name=="John",surname=="Insecure") %>%
  select(login)


proton(action = "login", login=login)

#Problem_2
data("top1000passwords")
top1000passwords[1]

for(i in top1000passwords){
  x <- proton(action="login",login=login,password=i)
}

#Problem_3
data("logs")
head(logs)

employees %>%
  filter(surname =="Pietraszko")

host<-logs %>%
  filter(login == "slap")%>%
  select(host)%>%
  group_by(host)%>%
  count()%>%
  arrange(n)%>%
  select(host)%>%
  head(1)
host

proton(action="server",host="194.29.178.16")
#Problem_4
data("bash_history")

bash_history %>%
  grep(pattern = " ",value = TRUE,invert = TRUE)%>%
  unique()

proton(action="login",login="slap",password="DHbb7QXppuHnaXGN")

