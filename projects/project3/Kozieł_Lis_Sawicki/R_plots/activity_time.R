library(readr)
library(ggplot2)
library(dplyr)

# sciezka do katalogu z csv przygotowanymi w pythonie
path <- "../data_preparation/data"

messages <- cbind(read_csv(paste(path,"/messages_Bartek_Sawicki.csv",sep = '')),person = "Bartek")
messages <- rbind(messages, cbind(read_csv(paste(path,"/messages_Kuba_Lis.csv",sep = '')),person = "Kuba L"))
messages <- rbind(messages, cbind(read_csv(paste(path,"/messages_Jakub_Koziel.csv",sep = '')), person = "Kuba K"))

notifications <- cbind(read_csv(paste(path,"/notifications_Bartek_Sawicki.csv",sep = '')),person = "Bartek")
notifications <- rbind(notifications, cbind(read_csv(paste(path,"/notifications_Kuba_Lis.csv",sep = '')),person = "Kuba L"))
notifications <- rbind(notifications, cbind(read_csv(paste(path,"/notifications_Jakub_Koziel.csv",sep = '')), person = "Kuba K"))

notifications %>%
  ggplot()+
  geom_bar(aes(x = floored_hour),stat = "count")+
  xlab("notification hour") + 
  ylab("number of notifications")


summary(messages)

messages %>%
  ggplot()+
  geom_bar(aes(x = floored_hour),stat = "count")+
  xlab("message hour") + 
  ylab("number of messages") -> plot

plot

plot + facet_wrap(~day_of_the_week)

plot + facet_wrap(~person)

plot + facet_grid(rows = vars(day_of_the_week), cols = vars(person))


messages %>%
  ggplot()+
  geom_point(aes(x = length, y = floored_hour))
