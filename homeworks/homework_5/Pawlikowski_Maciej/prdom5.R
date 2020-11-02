library(ggplot2)
library(dplyr)
Wojewodztwa<-c("mazowieckie","dolnoslaskie","malopolskie","slaskie","lodzkie","pomorskie","wielkopolskie","lubelskie","podlaskie","podkarpackie","zachodniopomorskie","kujawsko-pomorskie","lubuskie","opolskie","warminsko-mazurskie","swietokrzyskie")
Imigranci_proc<-as.numeric(as.character(c(27.1,8.9,8.7,8.4,7.7,6,5.9,5.6,3.8,3.7,3.4,2.5,2.5,2.4,2,1.5)))
dat<-data.frame("Data"=Imigranci_proc,"Respir"=Wojewodztwa)
sum(War)
length(Woj)

#piechart
ggplot(dat, aes(x=Wojewodztwa, y=Imigranci_proc, fill=Wojewodztwa)) +
  geom_bar(stat="identity", width=0.6) +
  coord_flip()

