#problem 1
w <- proton::employees

login <- dplyr::filter(w, name == "John", surname == "Insecure")
proton::proton(action = "login", login="johnins")

#problem 2
passwords <- proton::top1000passwords

for(password in passwords) {
  proton::proton(action = "login", login = "johnins", password = password)
}

#problem 3
logs <- proton::logs

loginPietraszko <- dplyr::filter(w, surname == "Pietraszko")

address <- dplyr::filter(logs, login == loginPietraszko$login)
address <- dplyr::count(address, host)
address <- dplyr::arrange(address, -n)

proton::proton(action = "server", host="194.29.178.16")

#problem 4
bash_history <- proton::bash_history
potentialPasswords <- sub(" .*", "", bash_history)
potentialPasswords <- data.frame(potentialPasswords)
potentialPasswords <- dplyr::count(potentialPasswords, potentialPasswords)
potentialPasswords <- dplyr::arrange(potentialPasswords, n)

proton::proton(action = "login", login = "slap", password = "DHbb7QXppuHnaXGN")