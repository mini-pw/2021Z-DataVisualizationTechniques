install.packages("proton")
install.packages("dplyr")
library(proton)
library(dplyr)
proton()
# get JS login
employees %>% filter(name=="John",surname == "Insecure") %>% select(login) 
proton(action = "login", login="johnins")

# crack JS password
func <- function(x)
{
  res <- proton(action="login",login="johnins",password=x)
  
}
Z <- lapply(top1000passwords,FUN=func)

#get SP login
employees %>% filter(surname == "Pietraszko") %>% select(login) 
#get most frequent host
logs %>% filter(login=="slap") %>% count(host)
proton(action = "server", host="194.29.178.16")
strsplit(bash_history," ") -> pom
v = c()
for(word in pom){
  v = c(v,word[[1]])
}
v <- unique(v)
v
proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")
