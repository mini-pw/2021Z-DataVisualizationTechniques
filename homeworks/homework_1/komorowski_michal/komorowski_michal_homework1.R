# instalacja pakietów

install.packages("dplyr")
install.packages("tidyr")
install.packages("proton")

# załadowanie pakietów

library("dplyr")
library("tidyr")
library("proton")

proton()

# sprawdzenie loginu

employees %>%
    filter(name == "John")

proton(action = "login", login = "johnins")

# zalogowanie sie jako johnins

for (p in top1000passwords) {
    proton(action = "login", login = "johnins", password = p)
}

# znalezienie loginu Pietraszko

employees %>%
    filter(surname == "Pietraszko")

# sprawdzenie jak wygląda logs

head(logs)

# wyfiltrowanie logów Pietraszko po czym pogrupowanie i zliczenie po hoscie

logs %>%
    filter(login == "slap") %>%
        group_by(host) %>%
            summarise(count = n(), .groups = "drop")

proton(action = "server", host = "194.29.178.16")

# za pomocą funkcji sub() filtrujemy pierwsze słowo następenie zamykamy w unique() i w związku z tym, że wektor ten jest bardzo krótki to łatwo widzimy wyróżniające się hasło 'DHbb7QXppuHnaXGN'

unique(sub(" .*", "", bash_history))

proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")
 
