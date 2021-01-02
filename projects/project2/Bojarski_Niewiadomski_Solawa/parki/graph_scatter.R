library(dplyr)
library(ggplot2)

#https://ourworldindata.org/grapher/change-visitors-parks-covid?tab=chart&stackMode=absolute&time=earliest..latest&country=~POL&region=World
# parks <- read.csv(file = "change-visitors-parks-covid.csv") %>%
#   filter(Entity == "Poland")%>%
#   select(Date, parks)
# write.csv(parks, "PolandParks.csv")




# https://ourworldindata.org/grapher/covid-stringency-index?tab=chart&stackMode=absolute&time=2020-01-22..latest&country=~POL&region=World
# index <- read.csv(file = "covid-stringency-index.csv") %>%
#   filter(Entity == "Poland")%>%
#   select(Date, stringency_index)
# write.csv(index, "PolandIndex.csv")



parks <- read.csv(file = "PolandParks.csv")
parks$Date <- as.Date(parks$Date)

index <- read.csv(file = "PolandIndex.csv")
index$Date <- as.Date(index$Date)



index <- index %>%
  filter(X >= 48)%>%
  select(Date, stringency_index)

parks <- parks%>%
  filter(X <= 286)%>%
  select(Date, parks)


P_index <- merge(parks, index)

Seasons <- c(rep(c("Winter"), 33),
             rep(c("Spring"), 92),
             rep(c("Summer"), 94),
             rep(c("Fall"), 67))



Color <- c(rep(c("#01BFFF"), 33),
             rep(c("#a7fc01"), 92),
             rep(c("#FFFE00"), 94),
             rep(c("#ff7f00"), 67))

P_index[,4] <- Seasons


xxx <- as.character(seq(0, 100, by=0.01))

  

ggplot(P_index , aes(x=as.factor(stringency_index), y=parks)) + 
  geom_boxplot(width = 250,size = 0.73, position = position_dodge(width = 1, preserve = c("total"))) +
  geom_jitter(aes(col = Seasons), size = 3, alpha = 0.6, width = 50 )+
  annotate("text", x=1, y=-70, label="a 0", col= "grey27", size = 4.4)+
  annotate("text", x=2500, y=-70, label="25", col= "grey27", size = 4.4)+
  annotate("text", x=5000, y=-70, label="50", col= "grey27", size = 4.4)+
  annotate("text", x=7500, y=-70, label="75", col= "grey27", size = 4.4)+
  annotate("text", x=9800, y=-70, label="100", col= "grey27", size = 4.4)+
  theme_minimal()+
  theme(legend.position = c(0.1, 0.8),
        legend.text=element_text(size=16),
        legend.title =element_blank(),
        axis.text.y.left= element_text(size = 16),
        panel.grid.major.x = element_blank() ,
        axis.ticks.x=element_blank(),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x=element_blank(),
        axis.title=element_text(size=16))+
  scale_color_manual(values=c("#e87605", "#7be108", "#e6b81a", "#01BFFF"))+
  scale_x_discrete(limits = xxx, name = "Government Response Stringency Index in Poland 2020")+
  scale_y_continuous(
    labels = c("0%","100%","200%"),
    breaks = c(0, 100, 200),
    name = "Change of parks and outdoor spaces visitors\nin Poland since the beginning of the pandemic",
  )

  