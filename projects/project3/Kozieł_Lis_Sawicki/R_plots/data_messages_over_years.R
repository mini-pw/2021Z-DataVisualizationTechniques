
path <- "data_preparation/data"
mess_Sawicki <-
  read_csv(paste(path, "/messages_Bartek_Sawicki.csv", sep = ''))
mess_Lis <-
  read_csv(paste(path, "/messages_Kuba_Lis.csv", sep = ''))
mess_Koziel <-
  read_csv(paste(path, "/messages_Jakub_Koziel.csv", sep = ''))

mess_Sawicki$date <-
  format(as.POSIXct(mess_Sawicki$date, format = '%Y-%m-%d %H:%M:%S'),
         format = "%Y-%m-%d")
mess_Lis$date <-
  format(as.POSIXct(mess_Lis$date, format = '%Y-%m-%d %H:%M:%S'),
         format = "%Y-%m-%d")
mess_Koziel$date <-
  format(as.POSIXct(mess_Koziel$date, format = '%Y-%m-%d %H:%M:%S'),
         format = "%Y-%m-%d")


start <-
  min(min(mess_Sawicki$date),
      min(mess_Koziel$date) ,
      min(mess_Lis$date))
end <-
  max(max(mess_Sawicki$date),
      max(mess_Koziel$date) ,
      max(mess_Lis$date))
complete_dates <- seq(as.Date(start), as.Date(end), by = "days")
complete_dates <- as.character(complete_dates)


number_Koziel <-
  as.data.frame(table(mess_Koziel$date[mess_Koziel$date %in% complete_dates]))
number_Sawicki <-
  as.data.frame(table(mess_Sawicki$date[mess_Sawicki$date %in% complete_dates]))
number_Lis <-
  as.data.frame(table(mess_Lis$date[mess_Lis$date %in% complete_dates]))

number_Koziel <- number_Koziel %>%
  rename(Date = Var1,
         Koziel = Freq)

number_Lis <- number_Lis %>%
  rename(Date = Var1,
         Lis = Freq)

number_Sawicki <- number_Sawicki %>%
  rename(Date = Var1,
         Sawicki = Freq)


total <-
  merge(number_Koziel,
        number_Sawicki,
        by = "Date",
        all = TRUE)
total <- merge(total, number_Lis, by = "Date", all = TRUE)


missingdates = complete_dates[!(complete_dates %in% total$Date)]
missingdates = data.frame(
  Date = missingdates,
  Koziel = NA_real_,
  Sawicki = NA_real_,
  Lis = NA_real_
)



total <- rbind(total, missingdates)
total <- total[order(total$Date),]
head(total)

total[is.na(total)] = 0



total


total$Date <- as.POSIXct(total$Date, format = '%Y-%m-%d')
head(total)

total

total_xts <- xts(total[,-1], order.by = total[, 1])
total_xts

mess_Sawicki$date <- as.Date(mess_Sawicki$date)
mess_Koziel$date <- as.Date(mess_Koziel$date)
mess_Lis$date <- as.Date(mess_Lis$date)

mess_Koziel$day_of_the_week <- factor(mess_Koziel$day_of_the_week , levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
mess_Lis$day_of_the_week <- factor(mess_Lis$day_of_the_week , levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
mess_Sawicki$day_of_the_week <- factor(mess_Sawicki$day_of_the_week , levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))


total_xts_rolling_small <- total_xts
total_xts_rolling_small$Koziel  <- rollmean(total_xts$Koziel, 15, fill = NA)
total_xts_rolling_small$Lis  <- rollmean(total_xts$Lis, 15, fill=NA)
total_xts_rolling_small$Sawicki  <- rollmean(total_xts$Sawicki, 15, fill = NA)


total_xts_rolling_mid <- total_xts
total_xts_rolling_mid$Koziel  <- rollmean(total_xts$Koziel, 30, fill = NA)
total_xts_rolling_mid$Lis  <- rollmean(total_xts$Lis, 30, fill=NA)
total_xts_rolling_mid$Sawicki  <- rollmean(total_xts$Sawicki, 30, fill = NA)




total_xts_rolling_big <- total_xts
total_xts_rolling_big$Koziel  <- rollmean(total_xts$Koziel, 60, fill = NA)
total_xts_rolling_big$Lis  <- rollmean(total_xts$Lis, 60, fill=NA)
total_xts_rolling_big$Sawicki  <- rollmean(total_xts$Sawicki, 60, fill = NA)




y_max <- max(max(mess_Koziel$length),max(mess_Lis$length),max(mess_Sawicki$length))

