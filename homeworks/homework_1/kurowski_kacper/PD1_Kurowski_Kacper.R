library( dplyr)
library( proton)

proton()

# Problem 1

employees %>% filter( name == 'John', surname == 'Insecure') #johnins

proton( action = 'login', login = 'johnins')

# Problem 2

for(i in 1:1000){ 
  if(proton(
      action = 'login',
      login = 'johnins',
      password = top1000passwords[i]) == 'Success! User is logged in!')
    print( top1000passwords[i]) # q1w2e3r4t5
  }

proton( action = 'login', login = 'johnins', password = 'q1w2e3r4t5')

# Problem 3


employees %>% filter( surname == 'Pietraszko') # login slap

logs %>% 
  filter( login == 'slap') %>%
  group_by( host) %>%
  select( host) %>%
  summarize( n = n()) %>%
  arrange( desc(n)) #194.29.178.16


proton(action = "server", host="194.29.178.16")

# Problem 4

unique( bash_history[ which( lengths( strsplit(bash_history, ' ')) == 1) ]) #DHbb7QXppuHnaXGN

proton( action = 'login', login = 'slap', password = 'DHbb7QXppuHnaXGN')

