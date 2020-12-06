library(dplyr)
library(tidyr)
library(ggridges)
library(ggplot2)
library("readxl")
Sys.setlocale("LC_CTYPE","polish")
# Wykorzystywane dane to .xlsx dla roku 2020 ze strony https://stat.gov.pl/obszary-tematyczne/ludnosc/ludnosc/zgony-wedlug-tygodni,39,2.html

woj <- c("PL21"="Lesser Poland", "PL22"="Silesian", "PL41"="Greater Poland", "PL42"="West Pomeranian", "PL43"="Lubusz", "PL51"="Lower Silesian", "PL52"="Opole", "PL61"="Kuyavian-Pomeranian", "PL62"="Warmian-Masurian", "PL63"="Pomeranian", "PL71"="Łódź", "PL72"="Holy Cross", "PL81"="Lublin", "PL82"="Subcarpathian", "PL84"="Podlaskie", "PL9"="Masovian")
wojPop <- c("PL21" =  3410901, "PL22" =  4517635, "PL41" =  3498733, "PL42" = 1696193, "PL43" = 1011592, "PL51" = 2900163, "PL52" = 982626, "PL61" = 2072373, "PL62" =  1422737, "PL63" =  2343928, "PL71" =  2454779, "PL72" = 1233961, "PL81" =  2108270, "PL82" = 2127164, "PL84" =  1178353, "PL9" = 5423168)

parseFile <- function(year, weeks, offset) {
  suppressMessages(
    DT <- read_excel(paste("20",year,".xlsx",sep=""))
  )
  DT <- filter(DT, DT[[2]] %in% names(woj))
  colnames(DT)[weeks] <- weeks+offset
  DT <- gather(DT, "Week", "Deaths", weeks) %>%
    filter(.[[1]] == "Ogółem") %>%
    select(Region = 2, Week, Deaths) %>%
    mutate(Deaths = as.numeric(Deaths)/wojPop[Region]*10**6, Region = woj[Region], Year = paste("20",year,sep=""))
  DT
}

DD <- parseFile(20,4:47,-4)

ggplot(DD, aes(x = as.numeric(Week), y = as.numeric(Deaths))) +
  geom_col() + 
  labs(y="Deaths per million citizens",
       x=element_blank(),
       title="Weekly deaths per million citizens throughout 2020") +
  scale_y_continuous(breaks = seq(0, 500, 200), labels=seq(0, 500, 200)) +
  scale_x_continuous(breaks = seq(2, 44, 30/7*2), labels=c("January", "March", "May", "July", "September"), expand = c(0.005,0)) +
  theme(panel.background = element_rect(fill = "#cfd5e5"),
        
        strip.text.y.right = element_text(angle = 0)) +
  facet_grid(Region ~ .)

