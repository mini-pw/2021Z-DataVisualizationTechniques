library(proton)
library(dplyr)
proton()


# problem 1
johnInsecureLogin <- employees %>% 
  filter(name == "John", surname == "Insecure") %>% 
  select(login)

proton(action = "login", login = johnInsecureLogin)


# problem 2
for(counter in 1:length(top1000passwords)){
  password <- top1000passwords[counter]
  ans <- proton(action = "login", login=johnInsecureLogin, password=password)
  if(ans != "Password or login is incorrect"){
    print(paste("Password 120 is correct:", top1000passwords[counter]))
    break
  }
}


# problem 3
pietraszkoLogin <- employees %>% 
  filter(surname == "Pietraszko") %>%
  select(login) %>%
  .$login

pietraszkoHost <- logs %>% 
  filter(login == pietraszkoLogin) %>% 
  group_by(host) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  head(1) %>%
  select(host) %>%
  .$host

proton(action = "server", host=toString(pietraszkoHost))


# problem 4
pietraszekPassword <- tibble(bash_history) %>%
  slice(grep(" ", bash_history, invert = TRUE)) %>%
  unique() %>%
  slice_tail() %>% #akurat wiem, że tam ono jest
  .$bash_history
  
proton(action = "login", login=pietraszkoLogin, password=pietraszekPassword)
