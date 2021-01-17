library("geosphere")
library(dplyr)
library(ggplot2)


blank_theme <- theme_minimal()+
  theme(
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )
weekDay <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
monthVec <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
Sys.setlocale(locale = "English")

running_data <- read.table("Source_data/running_data.txt", header = TRUE, sep = "\t")
running_data$date <- as.Date(running_data$date, format = "%Y-%m-%d")

df <- running_data

dfDays <- data.frame(date= df$date)

dayNum <- format(dfDays, format = "%d")


dfDays$month <- months(as.Date(dfDays$date))
dfDays$day <- weekdays(as.Date(dfDays$date))
dfDays$quarter <- quarters(as.Date(dfDays$date))
weekAsNumber <- as.numeric(strftime(df$date, "%u"))
monthAsNumber <- as.numeric(strftime(df$date, "%m"))


findq <- function(x){
  a1 <- x == "Q1"
  a2 <- x == "Q2"
  a3 <- x == "Q3"
  a4 <- x == "Q4"
  c = a1 + 2*a2 + 3*a3 + 4*a4
}

fiveOfTwo <- function(x){
  a5 <- x <= 5
  a2 <- x > 5
  c = a5 + 2*a2
}

df <- cbind(df, dfDays$day)
df <- cbind(df, dfDays$month)
df <- cbind(df, dayNum)
df <- cbind(df, dfDays$quarter)
df <- cbind(df, weekAsNumber)
df <- cbind(df, monthAsNumber)

colnames(df) <- c("date", "km", "h", "day", "month", "dayNum", "quarter", "wn", "mn")
z <- findq(df$quarter)
z1 <- fiveOfTwo(df$wn)
df <- cbind(df, z)
df <- cbind(df, z1)

kmeansdata <- df %>% select("h", "km")

####################
kmeansVector <- kmeans(kmeansdata , 2, iter.max = 10, nstart = 25)
df <- cbind(df,kmeansVector$cluster)

#############
kmeansVector <- kmeans(kmeansdata , 4, iter.max = 10, nstart = 25)
df <- cbind(df,kmeansVector$cluster)

#############

kmeansVector <- kmeans(kmeansdata , 7, iter.max = 10, nstart = 25)
df <- cbind(df,kmeansVector$cluster)

colnames(df) <- c("date", "km", "h", "day", "month", "dayNum", "quarter", "wn", "mn", "qn", "w5w2", "c1", "c2", "c3")

substr(monthVec[1:4], 1,3)

df$wn <- as.factor(df$wn)

dfM <- df %>% filter(df$day == "Monday") 
dfTu <- df %>% filter(df$day == "Tuesday") 
dfW <- df %>% filter(df$day == "Wednesday")
dfTh <- df %>% filter(df$day == "Thursday") 
dfF <- df %>% filter(df$day == "Friday") 
dfSa <- df %>% filter(df$day == "Saturday") 
dfSu <- df %>% filter(df$day == "Sunday") 

dfJan <- df %>% filter(df$month == "January") 
dfFeb <- df %>% filter(df$month == "February") 
dfMar <- df %>% filter(df$month == "March")
dfApr <- df %>% filter(df$month == "April") 
dfMay <- df %>% filter(df$month == "May") 
dfJun <- df %>% filter(df$month == "June") 
dfJul <- df %>% filter(df$month == "July") 
dfAug <- df %>% filter(df$month == "August") 
dfSep <- df %>% filter(df$month == "September") 
dfOct <- df %>% filter(df$month == "October")
dfNov <- df %>% filter(df$month == "November") 
dfDec <- df %>% filter(df$month == "December") 
dfAd <- rbind(dfApr, dfDec)

dfMAvr <- dfM %>% mutate(sum = sum(dfM$km)/dim(dfM)[1])
dfTuAvr <- dfTu %>% mutate(sum = sum(dfTu$km)/dim(dfTu)[1])
dfWAvr <- dfW %>% mutate(sum = sum(dfW$km)/dim(dfW)[1])
dfThAvr <- dfTh %>% mutate(sum = sum(dfTh$km)/dim(dfTh)[1])
dfFAvr <- dfF %>% mutate(sum = sum(dfF$km)/dim(dfF)[1])
dfSaAvr <- dfSa %>% mutate(sum = sum(dfSa$km)/dim(dfSa)[1])
dfSuAvr <- dfSu %>% mutate(sum = sum(dfSu$km)/dim(dfSu)[1])

dfJanAvr <- dfJan %>% mutate(sum = sum(dfJan$km)/dim(dfJan)[1])
dfFebAvr <- dfFeb %>% mutate(sum = sum(dfFeb$km)/dim(dfFeb)[1])
dfMarAvr <- dfMar %>% mutate(sum = sum(dfMar$km)/dim(dfMar)[1])
dfAprAvr <- dfApr %>% mutate(sum = sum(dfApr$km)/dim(dfApr)[1])
dfMayAvr <- dfMay %>% mutate(sum = sum(dfMay$km)/dim(dfMay)[1])
dfJunAvr <- dfJun %>% mutate(sum = sum(dfJun$km)/dim(dfJun)[1])
dfJulAvr <- dfJul %>% mutate(sum = sum(dfJul$km)/dim(dfJul)[1])
dfAugAvr <- dfAug %>% mutate(sum = sum(dfAug$km)/dim(dfAug)[1])
dfSepAvr <- dfSep %>% mutate(sum = sum(dfSep$km)/dim(dfSep)[1])
dfOctAvr <- dfOct %>% mutate(sum = sum(dfOct$km)/dim(dfOct)[1])
dfNovAvr <- dfNov %>% mutate(sum = sum(dfNov$km)/dim(dfNov)[1])
dfDecAvr <- dfDec %>% mutate(sum = sum(dfDec$km)/dim(dfDec)[1])

dfDayAvr <- rbind(head(dfMAvr,1), head(dfTuAvr,1),
                  head(dfWAvr, 1), head(dfThAvr,1), head(dfFAvr,1),
                  head(dfSaAvr,1), head(dfSuAvr,1))
dfDayAvr <- dfDayAvr %>% select("day", "sum")
dfDayAvr

dfMonthAvr <- rbind(head(dfJanAvr,1), head(dfFebAvr,1),
                    head(dfMarAvr, 1), head(dfAprAvr,1), head(dfMayAvr,1),
                    head(dfJunAvr,1), head(dfJulAvr,1),
                    head(dfAugAvr, 1), head(dfSepAvr,1), head(dfOctAvr,1),
                    head(dfNovAvr, 1), head(dfDecAvr,1))
dfMonthAvr <- dfMonthAvr %>% select("month", "sum")
dfMonthAvr

dfDayAvr$day <- factor(dfDayAvr$day, levels = dfDayAvr$day)
dfMonthAvr$month <- factor(dfMonthAvr$month, levels = dfMonthAvr$month)


