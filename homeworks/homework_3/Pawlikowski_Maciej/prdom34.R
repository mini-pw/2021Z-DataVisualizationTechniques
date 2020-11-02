library(ggplot2)
library(dplyr)
Date<-as.character(format(seq(as.Date("2020-10-01"), as.Date("2020-10-9"), by="days"),format="%d.%m"))
Resp<-as.numeric(as.character(c(130,50,20,53,25,60,130,120,50)))
dat<-data.frame("Data"=Date,"Respir"=Resp)

#Eksperyment 1 (piechart )
#piechart
ggplot(dat, aes(x="", y=Resp, fill=Date)) +
  geom_bar(stat="identity", width=0.6) +
  coord_polar("y", start=0)+
  theme_void()+
  scale_fill_manual(values=c("grey50","red","grey30","green","gray30","gray40","gray50","grey45","grey40"))+
  theme(
    legend.position="none"
  )
#barplot
ggplot(dat, aes(x=Date, y=Resp, fill=Date)) +
  geom_bar(stat="identity",width=0.6) +
  scale_fill_manual(values=c("grey50","red","grey30","gray30","gray40","green","gray50","grey45","grey40"))+
  theme(
    legend.position="none"
  )
#Eksperyment 2 (theme_void())
# 1
Resp3<-as.numeric(as.character(c(130,50,120,130,40,50,25,60,50)))
ggplot(dat, aes(x=Date, y=Resp3, fill=Date)) +
  geom_bar(stat="identity",width=0.6) +
  scale_fill_manual(values=c("grey50","red","grey30","gray30","gray40","green","gray50","grey45","grey40"))+
  theme_void()+
  theme(
    legend.position="none"
  )

# 2
Resp2<-as.numeric(as.character(c(130,52,120,130,40,50,25,60,50)))
ggplot(dat, aes(x=Date, y=Resp2, fill=Date)) +
  geom_bar(stat="identity",width=0.6) +
  scale_fill_manual(values=c("grey50","red","grey30","gray30","gray40","green","gray50","grey45","grey40"))+
  theme_void()+
  theme(
    legend.position="none"
  )



