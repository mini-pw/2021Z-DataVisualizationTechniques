proton()

#Problem 1
tmp <- employees %>%filter(name == 'John', surname == 'Insecure') #johnins
JohnLogin <- tmp[,3]
proton(action = "login", login=JohnLogin)

#problem2
for (i in c(1:1000)){proton(action = "login", login=JohnLogin, password = top1000passwords[i])}

#problem 3
tmp <- employees %>% filter(surname == 'Pietraszko') #slap
PietraszkoLogin <- tmp[,3]
PietraszkoLogs <- logs %>% filter(login == PietraszkoLogin) %>% count(host) %>% arrange(-n)
MostFreaquentHost <- as.character(PietraszkoLogs[1,1]) #194.29.178.16
proton(action = "server", host=MostFreaquentHost)

#problem 4
tmp <- bash_history %>% strsplit(" ")
commands <- c()
for (i in c(1:length(tmp))){commands <- c(commands, tmp[[i]][1])}
commands <- unique(commands)
commands
#DHbb7QXppuHnaXGN to wygl¹da na has³o
proton(action = "login", login="slap", password = "DHbb7QXppuHnaXGN")

