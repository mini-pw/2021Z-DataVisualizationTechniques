COVIDUSA <- read.csv("COVIDUSA.csv")
NCLH <- read.csv("NCLH.csv")
indeks_glowny <- read.csv("GSPC.csv")
NVDA <- read.csv("NVDA.csv")
ZM <- read.csv("ZM.csv")
APA <- read.csv("APA.csv")
library(dplyr)
library(ggplot2)
library(tidyr)
library(RColorBrewer)
options(stringsAsFactors=FALSE)
roznice_akcji <- inner_join(select(NVDA,Date,Adj.Close),select(ZM,Date,Adj.Close),by = "Date") %>% rename(CenyNVDA = Adj.Close.x,CenyZM = Adj.Close.y )
roznice_akcji <- inner_join(roznice_akcji,select(NCLH,Date,Adj.Close),by = "Date") %>% rename(CenyNCLH = Adj.Close)
roznice_akcji <- inner_join(roznice_akcji,select(indeks_glowny,Date,Adj.Close),by = "Date") %>% rename(CenyIndex = Adj.Close)
roznice_akcji <- inner_join(roznice_akcji,select(APA,Date,Adj.Close),by = "Date") %>% rename(CenyAPA = Adj.Close)
NVDA_pierwszy <- roznice_akcji$CenyNVDA[1]
ZM_pierwszy <- roznice_akcji$CenyZM[1]
NCLH_pierwszy <- roznice_akcji$CenyNCLH[1]
Index_pierwszy <- roznice_akcji$CenyIndex[1]
APA_pierwszy <- roznice_akcji$CenyAPA[1]
roznice_akcji <- roznice_akcji %>% mutate(NVDA_procenty = CenyNVDA/NVDA_pierwszy, zm_procenty =CenyZM/ZM_pierwszy,NCLH_procenty =CenyNCLH/NCLH_pierwszy,index_procenty =CenyIndex/Index_pierwszy,APA_procenty =CenyAPA/APA_pierwszy)
roznice_akcji <- select(roznice_akcji,Date,NVDA_procenty,zm_procenty,NCLH_procenty,index_procenty,APA_procenty)
roznice_akcji_long <- gather(roznice_akcji,firma,zmiana_ceny,NVDA_procenty,zm_procenty,NCLH_procenty,index_procenty,APA_procenty)

ggplot(roznice_akcji_long, aes(x = as.Date(Date))) + 
  geom_hline(yintercept=0, linetype="dashed")+
  geom_line(aes(y= zmiana_ceny*100-100,color = firma), size=1.3) + 
  scale_x_date(breaks = "1 month",date_labels = "%b" ) +
  scale_colour_brewer("", palette="Set2",labels = c("Apache Corporation","S&P 500 Index","Norwegian Cruise Line","Nvidia","Zoom")) + 
  labs(title = "Growth of selected companies' stock prices since Mar 1, 2020", x="Month", y="Stock price growth (%)")+
  theme_bw()+ 
  theme(title = element_text(size = 19), axis.title = element_text(size=14), 
        axis.text=element_text(size=14),
        legend.text = element_text(size=14))
  


