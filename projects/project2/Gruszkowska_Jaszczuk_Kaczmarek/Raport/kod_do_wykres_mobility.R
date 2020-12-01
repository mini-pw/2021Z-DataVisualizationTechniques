library(dplyr)
library(data.table)
library(ggplot2)

a <- fread("2020_PL_Region_Mobility_Report.csv")
a <- a %>%
  select(date,retail_and_recreation_percent_change_from_baseline,grocery_and_pharmacy_percent_change_from_baseline,parks_percent_change_from_baseline,transit_stations_percent_change_from_baseline,workplaces_percent_change_from_baseline,residential_percent_change_from_baseline)
a$date = as.Date(a$date)

nowe_przypadki <- read.table("Dane.csv",header=TRUE, sep=";")
nowe <-data.frame(nowe_przypadki$Data, nowe_przypadki$Nowe.przypadki)
colnames(nowe) <- c("date", "ilosc")

minimum<-as.Date("2020-03-04")
maximum<-as.Date("2020-11-17")
nowe$date<- as.Date(nowe$date)

b <- a %>%
  filter(date>=minimum)
c<-nowe%>%
  filter(date<=maximum)

wynikowe<-inner_join(b,c,by = "date")
wynikowe$ilosc<- wynikowe$ilosc/1000

pp2<-ggplot(rbind(data.frame(x=wynikowe$date,y=wynikowe$retail_and_recreation_percent_change_from_baseline,type="retail_and_recreation"),
                  data.frame(x=wynikowe$date,y=wynikowe$grocery_and_pharmacy_percent_change_from_baseline,type="grocery_and_pharmacy"),
                  data.frame(x=wynikowe$date,y=wynikowe$workplaces_percent_change_from_baseline,type='workplaces'),
                  data.frame(x=wynikowe$date,y=wynikowe$residential_percent_change_from_baseline,type='residential'),
                  data.frame(x=wynikowe$date,y=wynikowe$ilosc,type = 'disease rate per 1,00 inhabitants')),
            aes(x=x,y=y,color=type))+
  geom_smooth()+
  scale_color_manual(values = c("retail_and_recreation" = '#E69F00',
                                "grocery_and_pharmacy" = '#56B4E9',
                                "workplaces" = '#009E73',
                                "residential" = '#D55E00',
                                "disease rate per 1,00 inhabitants" = "#000000"))+
  scale_y_continuous(name = "Mobility(%)",
                     sec.axis = sec_axis(~.+0,name = "Disease rate per 1,000 inhabitants"))+
  theme_light()+
  ggtitle("Comparison of the trend of Covid to mobility in Poland")+
  xlab("Date")
pp2

