proton::proton()

# 1
proton::employees %>%
  filter(name =="John", surname == "Insecure") %>%
  select("login") %>%
  toString ->
  john_ins_login

proton::proton(action = "login", login=john_ins_login)

# 2
for (pass in proton::top1000passwords) { 
  if(proton::proton(action ="login", login=john_ins_login, password=pass) == "Success! User is logged in!") {
    john_ins_password <- pass
  }
}
pass <- NULL

proton::proton(action ="login", login=john_ins_login, password=john_ins_password)

# 3
proton::employees %>%
  filter(surname == "Pietraszko") %>%
  select(login) %>%
  toString() ->
  pietraszko_login

proton::logs %>%
  filter(login == pietraszko_login) %>%
  group_by(host) %>%
  summarise(count = n()) %>%
  arrange(-count) %>%
  head(1) %>%
  select(host) %>%
  pull %>% # kombinacje żeby dobrze się zamieniło na string
  toString ->
  ip_str

## ip_str <- "194.29.178.16"

proton::proton(action="server", host=ip_str)

# 4
proton::bash_history[grepl("^\\w+$", proton::bash_history)] %>% # brzydko ale nie wiem jak ładnie zrobić RegExa w dplyrze 
  tbl_df() %>% 
  group_by(value) %>% 
  summarise(count = n()) -> 
  candidates

# Ręcznie popatrzeć

pietraszko_password <- "DHbb7QXppuHnaXGN"

proton::proton(action="login", login=pietraszko_login, password=pietraszko_password)
