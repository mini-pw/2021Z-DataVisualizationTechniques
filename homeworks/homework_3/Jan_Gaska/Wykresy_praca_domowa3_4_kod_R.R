library(dplyr)
library(plotrix)
library("RColorBrewer")
library(labelVector)


Population_of_the_wrold = sum(countries$population)
continents_population <- group_by(countries,continent) %>%
  summarize(Percentage = (100*sum(population)/Population_of_the_wrold))
continents_population

pie3D(continents_population$Percentage,labels = continents_population$continent,main = "Distribution of population by continents",col = brewer.pal(n = 5, name = "GnBu"),
      radius = 1, theta = 2*pi/5,start = pi/4)
ccc < data(countries)

wartosci_realne = continents_population$Percentage
names(wartosci_realne) <- c("Africa","Americas","Asia","Europe","Oceania")


wyniki_Afryka <- c(18,15,12,15,10,16,15,13,15,16,13,11,10,9,16,16,13,12,9,20,15,25)
wyniki_Americas <-c(10,15,10,8,10,15,14,12,15,14,11,10,9,9,14,14,11,14,9,17,14,25)
wyniki_Asia <-c(60,60,70,68,68,54,57,61.5,58,57,55,60,63,62.5,61,59,56,55,56,67,58,75)
wyniki_Europe <-c(10,10,8,8,10,14,14,12,10,13,11,10,9,7,9,13,11,14,8,17,12,24)
wyniki_Oceania <-c(2,1,1,1,2,1,2.5,1.5,1,1.5,0.4,0.5,1,1,0,1,0.3,0.4,0.7,0.7,1,2)


boxplot(wyniki_Afryka, wyniki_Americas, wyniki_Asia,wyniki_Europe,wyniki_Oceania,
        names=c("Afryka","Ameryki","Azja","Europa","Oceania"),main="Odchylenie dla ka¿dego z kontynentów",
        xlab="Kontynenty",
        ylab="Wartoœæ w procentach",
        col="steelblue",
        border="black") 

points(c(1,2,3,4,5), c(14,13.4,61.4,10.6,0.54), col = "orange",pch=19)

mean(wyniki_Afryka)
sd(wyniki_Afryka)
mean(wyniki_Americas)
sd(wyniki_Americas)
mean(wyniki_Asia)
sd(wyniki_Asia)
mean(wyniki_Europe)
sd(wyniki_Europe)
mean(wyniki_Oceania)
sd(wyniki_Oceania)


