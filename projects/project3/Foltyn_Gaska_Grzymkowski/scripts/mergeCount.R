# skrypt łączy pliki wygenerowane za pomocą createData.R w jeden, potrzebny do wykresów

library(dplyr)

kacper_c <- read.csv("kacperCount.csv")
jakub_c <- read.csv("jakubCount.csv")
jan_c <- read.csv("janCount.csv")
all_c <- bind_rows(
  kacper_c %>% select(-X) %>% mutate("user" = "kacper"),
  jakub_c %>% select(-X) %>% mutate("user" = "jakub"),
  jan_c %>% select(-X) %>% mutate("user"= "jan")
) %>% rename("date" = "time_usec")

write.csv(all_c, "allCount.csv", row.names = F)
