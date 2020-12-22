library("ggplot2")
library("ggimage")
set.seed(1)
pog1<- data.frame(x = seq(5.10,5.90,length.out = 2), y = rep(0,2))
pog2<- data.frame(x = seq(5.10,5.90,length.out = 2), y = rep(2,2))
SSSsss <- data.frame(x = 1:10, y = 3)
SSSsss2 <- data.frame(x = seq(1.5,9.5,length.out = 9), y = 4)
SSSsss3 <- data.frame(x = seq(2,9,length.out = 8), y = 5)
SSSsss4 <- data.frame(x = seq(2.5,8.5,length.out = 7), y = 6)
SSSsss5 <- data.frame(x = seq(3,8,length.out = 6), y = 7)
SSSsss6 <- data.frame(x = seq(3.5,7.5,length.out = 5), y = 8)
SSSsss7 <- data.frame(x = seq(2,9,length.out = 8), y = 9)
SSSsss8 <- data.frame(x = seq(2.5,8.5,length.out = 7), y = 10)
SSSsss9 <- data.frame(x = seq(3,8,length.out = 6), y = 11)
SSSsss10 <- data.frame(x = seq(3.5,7.5,length.out = 5), y = 12)
SSSsss11 <- data.frame(x = seq(4,7,length.out = 4), y = 13)
SSSsss12 <- data.frame(x = seq(4.5,6.5,length.out = 3), y = 14)
SSSsss13 <- data.frame(x = seq(4,7,length.out = 4), y = 15)
SSSsss14 <- data.frame(x = seq(4.5,6.5,length.out = 3), y = 16)
SSSsss15 <- data.frame(x = seq(5,6,length.out = 2), y = 17)
SSSsss16 <- data.frame(x = 5.5, y = 18)
HolidayPresent<-data.frame(x = c(2,3,7.5), y = rep(1,3))
TwitchSings<-data.frame(x=5.5,y=19)
HolidayOrnament<-data.frame(x=c(3,6,5),y=c(5,7,12.5))
HolidayLog<-data.frame(x=c(7.5,3.5,7),y=c(6,7.5,12))
KappaClaus<-data.frame(x=c(8.75,4,5.5),y=c(3,10,15))


sizeSSSsss=0.07
p<-ggplot(SSSsss, aes(x = x, y = y)) +
  geom_twitchemote(aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss2,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss3,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss4,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss5,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss6,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss7,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss8,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss9,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss10,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss11,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss12,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss13,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss14,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss15,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=SSSsss16,aes(image = 'SSSsss'), size = sizeSSSsss)+
  geom_twitchemote(data=TwitchSings,aes(image = 'TwitchSings'), size = 0.1)+
  geom_twitchemote(data = pog1,aes(image = 'pogchamp'), size = 0.08, alpha = 0.3)+
  geom_twitchemote(data = pog2,aes(image = 'pogchamp'), size = 0.08, alpha = 0.3)+
  geom_twitchemote(data = HolidayPresent,aes(image = 'HolidśayPresent'), size = 0.2, alpha = 0.3)+
  geom_twitchemote(data = HolidayOrnament,aes(image = 'HolidayOrnament'), size = 0.1, alpha = 0.3)+
  geom_twitchemote(data = HolidayLog,aes(image = 'HolidayLog'), size = 0.1, alpha = 0.3)+
  geom_twitchemote(data = KappaClaus,aes(image = 'KappaClaus'), size = 0.1, alpha = 0.3)

p + theme(axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),legend.position="none",
          panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),plot.background=element_blank())

