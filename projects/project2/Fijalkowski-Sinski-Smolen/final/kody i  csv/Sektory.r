energy <- read.csv("XOM.csv")
technology <- read.csv("AAPL.csv")
financials <- read.csv("JPM.csv")
real_estate <- read.csv("AMT.csv")
consumer <- read.csv("AMZN.csv")
health_care <- read.csv("UNH.csv")

library(ggplot2)
library(dplyr)
library(tidyr)

roznice_akcji <- inner_join(select(energy,Date,Adj.Close),select(technology,Date,Adj.Close),by = "Date")
joined_1 <- select(energy,Date,Adj.Close) %>% right_join(select(technology,Date,Adj.Close),by = "Date")  %>% right_join(select(financials,Date,Adj.Close),by = "Date") 
colnames(joined_1) <- c("Date","Energy","Technology","Financials")
joined_2 <- select(real_estate,Date,Adj.Close)  %>% right_join(select(consumer,Date,Adj.Close),by = "Date") %>% right_join(select(health_care,Date,Adj.Close),by = "Date")
colnames(joined_2) <- c("Date","Real_estate","Consumer_service","Health_care")
joined <- as.data.frame(inner_join(joined_1,joined_2,by="Date"))

firsts = c()

for(colname in colnames(joined)[-1]){
  firsts <- c(firsts,unlist(joined[colname])[1])
}
firsts <- as.numeric(firsts)
diffs <- joined %>% 
  mutate(Energy = 100*Energy/firsts[1], Technology = 100*Technology/firsts[2], Financials = 100*Financials/firsts[3], Real_estate= 100*Real_estate/firsts[4],Consumer_service=100*Consumer_service/firsts[5],Health_care=100*Health_care/firsts[6])

diffs_long <- gather(diffs,sector,change,Energy,Technology,Financials,Real_estate,Consumer_service,Health_care)

wykres <- ggplot(diffs_long, aes(x = as.Date(Date))) + 
  geom_hline(yintercept=0, linetype="dashed")+
  geom_line(aes(y= change-100,color = sector), size=1.3) + 
  scale_x_date(breaks = "1 month",date_labels = "%b" ) +
  scale_colour_brewer("", palette="Set2",labels=c("Consumer Service","Energy","Financials","Health Care","Real Estate","Technology")) + 
  labs(title = "Growth of economic sectors since Mar 1, 2020 ", x="Month", y="Stock price growth (%)")+theme_bw() + 
  theme(title = element_text(size = 19),axis.title = element_text(size=14),
        axis.text=element_text(size=14),
        legend.text=element_text(size=14))+
  scale_y_continuous(breaks=c(-25,0, 25, 50, 75))
wykres
