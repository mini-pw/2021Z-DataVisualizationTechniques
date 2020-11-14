library(gridExtra)
library(ggplot2)

drugi_nazwy <- c("polska", "niepolska", "nieustalona")
drugi_wartosci <- c((36983.7/38230.1*100), 471.5/38230.1*100, 774.9/38230.1*100)
drugi <- data.frame(drugi_nazwy, drugi_wartosci)
drugi

jedenasty_nazwy <- c("polska", "niepolska", "nieustalona")
jedenasty_wartosci <- c(36522.2/38511.8*100, 1467.7/38511.8*100, 521.9/38511.8*100)
jedenasty <- data.frame(jedenasty_nazwy, jedenasty_wartosci)
jedenasty


jedenascie <- ggplot(data=jedenasty, aes(x=jedenasty_nazwy, y=jedenasty_wartosci, fill=jedenasty_nazwy))+
              geom_bar(stat = "identity")+
              xlab("2011")+
              ylab("% narodu w 2011")+
              theme(legend.position = "none")

jedenascie
dwa <- ggplot(data=drugi, aes(x=drugi_nazwy, y=drugi_wartosci, fill=drugi_nazwy))+
       geom_bar(stat="identity")+
       xlab("2002")+
       ylab("% narodu w 2002")
dwa  


grid.arrange(dwa + theme(legend.position = "none"), jedenascie, ncol=2, 
              top = textGrob("Identyfikacja narodowo-etniczna",gp=gpar(fontsize=15,font=3)))


