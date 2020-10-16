#install.packages("proton")
library(dplyr)
library(proton)
library(tidyr)


# znalezienie loginu insecure
l <- employees %>% filter(name=="John" & surname =="Insecure") %>% select("login")

proton(action = "login", login=l)


# znalezienie hasla insecure

for(h in top1000passwords) {
  if (proton(action = "login", login=l, password=h) =="Success! User is logged in!" ){
    haslo <- h
  }
}

# login pietraszka
pietr <- employees %>% filter(surname =="Pietraszko") %>% select("login")


#host pietraszka

logs %>%
  group_by(login, host) %>%
  count() %>% 
  mutate(lo = as.character(login))  %>%
  filter(lo==pietr) %>%
  arrange(desc(n)) %>%
  ungroup()  %>%
  mutate(h=as.character(host)) -> hosty

host <- as.character(hosty[1, "h"])


proton(action="server", host=host)

#znalezienie hasla

historia <- as.data.frame(x=bash_history)
colnames(historia) <- "a"
historia%>% 
  separate("a", c("komenda", "arg"), extra = "merge") %>% 
  group_by(komenda) %>% 
  count() %>%
  filter( n==1) ->haslo_pietr


#zmiana z tibble na character
hh <- as.vector(haslo_pietr[[1,1]])


##koniec! :D 

proton(action="login", login = pietr, password = hh)
