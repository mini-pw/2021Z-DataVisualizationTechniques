library(proton)
library(dplyr)
library(stringr)

proton()

# task 1
johns_record <- employees %>%
  filter(name == "John", surname == "Insecure")


proton(action='login', login=johns_record$login)

# task 2
for(pass in top1000passwords){
  proton(action='login', login=johns_record$login, password = pass)
}

# task 3
employees %>%
  filter(surname == 'Pietraszko')

logs %>%
  filter(login == 'slap')%>%
  count(host) %>%
  arrange(-n)

proton(action = 'server', host = '194.29.178.16')

# task 4
filter_vector <- bash_history%>%
  str_detect(" ")

bash_history[!filter_vector] %>%
  unique()

proton(action='login', login='slap', password = 'DHbb7QXppuHnaXGN')