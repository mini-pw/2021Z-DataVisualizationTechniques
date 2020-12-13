library(dplyr)
library(ggplot2)
library(ggthemes)
library(ggrepel)
options(stringsAsFactors = FALSE)


dfNames <- read.csv("Names.csv")   #pomocnicza df z nazwami krajow
#WIELKAdf <- read.csv("G20-Deaths.csv")
#dfD <- WIELKAdf %>% mutate(date=as.Date(date, format='%Y-%m-%d'))
#dfD <-dfD %>% filter(date=="2020-07-01")
#dfD <- dfD %>% choose(location, total_deaths_per_million, total_tests_per_thousand) 

#G20 <- inner_join(dfNames, dfD, by=c("Country"="location"))
#G20 <- G20 %>% select(Country, total_deaths_per_million, Value, total_tests_per_thousand) 
#write.csv(G20, "G20.csv")
G20 <- read.csv("G20.csv")
g20Annual <- read.csv("imf-dm-export.csv", sep=";", stringsAsFactors = FALSE)
#dfD2 <- WIELKAdf %>% mutate(date=as.Date(date, format='%Y-%m-%d'))
#dfD2 <-dfD2 %>% filter(date=="2020-11-29")
#write.csv(dfD2, "dfD2.csv")
dfD2 <- read.csv("dfD2.csv")
colnames(g20Annual)[1] <- "Country"
g20Annual <- g20Annual %>% mutate(Country = replace(Country, Country=="China, People's Republic of", "China" ))
g20Annual <- g20Annual %>% mutate(Country = replace(Country, Country=="Russian Federation", "Russia") )
g20Annual <- g20Annual %>% mutate(Country = replace(Country, Country=="Korea, Republic of", "South Korea") )
g20Annual <- g20Annual %>% filter(Country %in% dfNames$Country)
dfD2 <- dfD2 %>% mutate(location = replace(location, location=="China (People's Republic of)", "China") )
dfD2 <- dfD2 %>% mutate(location = replace(location, location=="Korea", "South Korea") )
Roczne <- inner_join(g20Annual, dfD2, by=c("Country"="location")) %>% select(Country, X2020, total_deaths_per_million)
Roczne$total_deaths_per_million<-as.numeric(Roczne$total_deaths_per_million)
Roczne$X2020 <- as.numeric(gsub(",", ".", Roczne$X2020))





y <-ggplot(Roczne, aes(x=X2020, y=total_deaths_per_million, label=Country))+
  geom_point(size=5, color='darkslategray3')+
  geom_text_repel(box.padding = 0.4, segment.size = 0, segment.color = 'transparent', size=5)+
  theme_bw()+
  labs(title="GDP growth in 2020 vs deaths due to COVID-19 in selected countries", x="GDP growth in 2020 (%)", y="Deaths per million")+
  geom_smooth(se=FALSE, color='darkslategray4') +  
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1100))+
  stat_smooth(fullrange=TRUE,geom='ribbon', aes(ymin = ifelse(..ymin.. < 0, 0, ..ymin..), ymax=ifelse(..ymax..>1100, 1100, ..ymax..)), alpha = .07)+
  theme(title=element_text(size=17.5),
        axis.title=element_text(size=14),
        axis.text = element_text(size=14))
  
y



Years <- as.character(2009:2020)
GlobalGDP <- c(-0.1, 5.4,	4.3,	3.5,	3.4,	3.5,	3.4,	3.2,	3.8,	3.5,	2.8,	-4.4)
dfYears <- data.frame(Years, GlobalGDP)
barowy <- ggplot(dfYears, aes(x=Years, y=GlobalGDP))+
  geom_hline(yintercept=0, linetype="dashed")+
  geom_bar(stat='identity', fill='darkslategray3')+theme_bw()+ylim(-5,8)+
  labs(title="Annual global GDP growth from 2009 to 2020", x="Year", y="Global GDP growth (%)")+
   geom_text(aes(label=GlobalGDP), vjust=-GlobalGDP/abs(GlobalGDP), size=7)+
   theme(title=element_text(size=19),
         axis.title=element_text(size=14),
         axis.text = element_text(size=14))
barowy



