  library(dplyr)
library(ggplot2)
data<-read.csv("Source_data/plot_data.csv")
data%>%
  ggplot(aes(x=precipitation_type,y=time_h))+
  geom_boxplot()


data%>%
  ggplot(aes(x=temperature,y=distance_km/time_h))+
  geom_point()

