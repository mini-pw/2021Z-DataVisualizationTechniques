library(dplyr)
library(proton)
library(stringi)

proton()

login_ins <- employees %>% 
  filter(surname=="Insecure", name=="John") %>% 
  select(login) %>% 
  toString()
proton(action = "login", login=login_ins)


for(password in top1000passwords){
  proton(action = "login", login=login_ins, password=password)
}

login_piet <- employees %>% 
  filter(surname=="Pietraszko") %>% 
  select(login) %>% 
  toString()

host <- logs %>% 
  filter(login==login_piet) %>% 
  count(host) %>% 
  arrange(-n) %>% 
  head(1) %>% 
  select(host) %>% 
  pull() %>% 
  toString()

proton(action = "server", host=host)


commands <- bash_history %>% 
  stri_split_fixed(" ") %>% 
  vapply(`[`, 1, FUN.VALUE=character(1)) %>% 
  unique()

password_piet <- tail(commands,1)

proton(action = "login", login=login_piet, password=password_piet)
