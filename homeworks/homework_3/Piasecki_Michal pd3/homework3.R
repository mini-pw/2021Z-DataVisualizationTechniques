install.packages('dplyr')
install.packages('ggplot2')
library(ggplot2)
library(dplyr)
options(scipen = 999)
dane <- read.csv('imiona.csv')
colnames(dane) <- c("imie", "ilosc", "plec")
dane$ilosc = as.numeric(dane$ilosc)
dane <- dane[1:7,]
j <- ggplot(dane, aes(x = imie, y = ilosc)) +
  geom_bar(stat = "identity", fill = "pink") +
  theme(axis.text.y = element_blank(), 
        panel.grid = element_blank() )
png("slupkowy.png")
plot(j, main = "my test PDF")
dev.off()
g <-ggplot(dane, aes(x="", y=ilosc, fill=imie)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void()
png("kolowy.png")
plot(g, main = "my test PDF")
dev.off()