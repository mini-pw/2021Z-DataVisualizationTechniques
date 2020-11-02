library(ggplot2)
library(dplyr)


data <- data.frame(Rok = 2000:2019, Wartość = c(5,7,14,18,22,25,26,30,40,45,50,54,52,45,37,32,28,24,15,19), kolor = c("steelblue", "steelblue", "red","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","steelblue","red","steelblue"))

ggplot(data, aes(x= Rok, y = Wartość, fill = kolor)) + geom_bar(stat="identity") + guides(fill=FALSE)