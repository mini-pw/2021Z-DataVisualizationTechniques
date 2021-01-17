library("readxl")
library(dplyr)


M4 <- read_xlsx("1-6_achievement-gender-trends-M4.xlsx", skip = 5) 
namCol1 <- colnames(M4) 
choseCol1 <- seq(3, 27, 2)
M4 <- M4 %>% select(namCol1[choseCol1])
country <- as.data.frame(M4 %>% select("Country") %>% na.omit())
n = dim(country)
namCol2 <- colnames(M4)
choseCol2 <- seq(2, 12, 2)
girls <- as.data.frame(M4 %>% select(namCol2[choseCol2]) %>% slice(2:52, 54:57))
girls <- cbind(country, girls)
boys <- as.data.frame(M4 %>% select(namCol2[choseCol2 +1]) %>% slice(2:52, 54:57))
boys <- cbind(country, boys)
colnames(boys) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")

