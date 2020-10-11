options(stringsAsFactors = FALSE)
library("dplyr")
library("stringi")

#proton()

employees %>%
  filter(name == 'John', surname == 'Insecure') -> JI_login
JI_login <- JI_login[[3]]

#proton(action = "login", login = JI_login)

passwords_df <- data.frame(x = top1000passwords)

for(i in 1:1000) passwords_df[[i, 2]] = proton(action = "login", login = x, password = top1000passwords[i])
passwords_df %>%
  filter(y == "Success! User is logged in!") -> JI_password
JI_password <- JI_password[[1]]

#proton(action = "login", login = x, password = JI_password)

SP_login <- filter(employees, surname == "Pietraszko")[[3]]

logs %>%
  filter(login == SP_login) %>%
  select(host) %>%
  group_by(host) %>%
  summarize(number = n()) %>%
  arrange(desc(number)) -> logi

logi <- data.frame(lapply(logi, as.character), stringsAsFactors=FALSE)

server <- logi[1, 1]

#proton(action = "server", host = server)

commands <- stri_extract_first_regex(bash_history, ".* ")
commands <- is.na(commands)
commands <- bash_history[commands]

data.frame(x = commands) %>%
  group_by(x) %>%
  summarise(number = n()) %>%
  arrange(number) -> commands

SP_password <- commands[[1, 1]]

proton(action = "login", login = SP_login, password = SP_password)