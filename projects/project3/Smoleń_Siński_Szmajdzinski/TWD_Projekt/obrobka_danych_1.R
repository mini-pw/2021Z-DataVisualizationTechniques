library(jsonlite)
library(dplyr)

library(ggplot2)
library(plotly)
library(shiny)
library(stringr)
library(RColorBrewer)


history <- fromJSON("./JS/StreamingHistory0.json")
history <- rbind(history, fromJSON("./JS/StreamingHistory1.json"))
history <- rbind(history, fromJSON("./JS/StreamingHistory2.json"))
history <- rbind(history, fromJSON("./JS/StreamingHistory3.json"))

history <- fromJSON("./BS/StreamingHistory0.json")
history <- rbind(history, fromJSON("./BS/StreamingHistory1.json"))

history <- fromJSON(readLines("./SS/StreamingHistory0.json"))


b <- history
b$endTime <- as.Date(b$endTime, "%Y-%m-%d")
b <-  b %>% filter(msPlayed>30000)
b <- b %>% select(artistName, endTime)
b$artistName <- ifelse(nchar(b$artistName)>18, paste(substr(b$artistName, 1, 15),"...", sep=""), b$artistName)
b$artistName <- str_pad(b$artistName, 18, "left")



colordf <- b %>% distinct(artistName)
colordf$artistName <- as.character(colordf$artistName)
k <- length(colordf$artistName)
color<- rep(sample(brewer.pal(12, "Set3")), k%/%12)
tmp <- sample(brewer.pal(12, "Set3"))
tmp <- tmp[0:(k%%12)]
color <- append(color, tmp)
colordf <- cbind(colordf, color)
write.csv(colordf, "SmolenColor.csv")


g <-history 
g$endTime <- as.Date(g$endTime, "%Y-%m-%d")
g <- g %>% filter(endTime>"2019-12-31" & endTime<"2020-12-01")
g <-  g %>% filter(msPlayed>30000)
g <- g %>% select(artistName, endTime)
gd <- (g %>% distinct(endTime))$endTime 
gd <- seq(as.Date("2020-01-01"), as.Date("2020-12-01"), by="days")
gz <- rep(gd, each=10)
gz <- as.Date(gz)


gz
top <-c()
no <- c()
pos <- rep( c(1:10), length(gd))
date<-c()
#for(d in gd){
#  date <- append(gz,rep(d, 10) )}
#  date <- as.Date.numeric(gz, origin='1970-01-01')

for(d in c(1:length(gd))){
  j <- g %>% filter(endTime<=gd[d])
  top <- append(top,   (j %>% count(artistName) %>% arrange(-n) %>% top_n(10))$artistName[1:10])
  no <- append(no,  (j %>% count(artistName) %>% arrange(-n) %>% top_n(10))$n[1:10])
 
 }

z <- data.frame(date=gz, pos, artistName=top, no)
z$artistName <- as.character(z$artistName)
z$artistName <- ifelse(nchar(z$artistName)>18, paste(substr(z$artistName, 1, 15),"...",sep=""), z$artistName)  #18, 15 było
z$artistName <- str_pad(z$artistName, 18, "left")
z <- left_join(z, colordf)


write.csv(z, "SzmejAnim.csv")
write.csv(b, "SzmejRange.csv")

write.csv(z, "SmolenAnim.csv")
write.csv(b, "SmolenRange.csv")


write.csv(z, "SinskiAnim.csv")
write.csv(b, "SinskiRange.csv")


write.csv(colordf, "SzmejColor.csv")





setwd("C:/Users/Jan/Documents/TWP/projekt3")
getwd()


#fig <- plot_ly(z, x = ~pos[1:10], y = ~no[1:10], frame=~gz[1:10])


#fig


#wykres <- ggplot(z, aes(x=pos, y=no))+
#  geom_bar(aes(frame=gz), stat="identity")+
# coord_flip()


#ggplot(wykres)
