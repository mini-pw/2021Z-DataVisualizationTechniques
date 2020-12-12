# README
# wygenerowanie mapy dla danego zanieczyszczenia wymaga zmian w 2 miejscach. 
# Zmianiamy zmienna rodzajZanieczyszczenia, a takze argument wywolania funkcji rysuj. Przyda się tez odpowiedni tytul.




library(dplyr)
library(ggplot2)
library(tidyr)
library(maps)
library(RJSONIO)
library(sp)
library(maptools)
library(RColorBrewer)

#wczytanie dancyh
# rok2020 <- read.csv("waqi-covid19-airqualitydata-2020.csv", encoding = "UTF-8")
# 
# rok2019 <- read.csv("waqi-covid19-airqualitydata-2019Q1.csv", encoding = "UTF-8")
# rok2019_2 <- read.csv("waqi-covid19-airqualitydata-2019Q2.csv", encoding = "UTF-8")
# rok2019_3 <- read.csv("waqi-covid19-airqualitydata-2019Q3.csv", encoding = "UTF-8")
# rok2019_4 <- read.csv("waqi-covid19-airqualitydata-2019Q4.csv", encoding = "UTF-8")
# rok2019 <- rbind(rok2019, rok2019_2, rok2019_3, rok2019_4)
# 
# rok2018 <- read.csv("waqi-covid19-airqualitydata-2018H1.csv", encoding = "UTF-8")
# rok2017 <- read.csv("waqi-covid19-airqualitydata-2017H1.csv", encoding = "UTF-8")
# rok2016 <- read.csv("waqi-covid19-airqualitydata-2016H1.csv", encoding = "UTF-8")


rok2020 <- read_csv("waqi-covid-2020.csv", skip=4)

rok2019 <- read.csv("waqi-covid19-2019Q1.csv", skip = 4)
rok2019_2 <- read.csv("waqi-covid19-2019Q2.csv", skip = 4)
rok2019_3 <- read.csv("waqi-covid19-2019Q3.csv", skip = 4)
rok2019_4 <- read.csv("waqi-covid19-2019Q4.csv", skip = 4)
rok2019 <- rbind(rok2019, rok2019_2, rok2019_3, rok2019_4)

rok2018 <- read.csv("waqi-covid19-2018H1.csv", skip = 4)
rok2017 <- read.csv("waqi-covid19-2017H1.csv", skip = 4)
rok2016 <- read.csv("waqi-covid19-2016H1.csv", skip = 4)





#wspolrzedne dla polskich miast
miasta <- rok2020 %>% filter(Country == c("PL")) %>% distinct(City) %>% select(City)


nrow <- nrow(miasta)
counter <- 1
miasta$lon[counter] <- 0
miasta$lat[counter] <- 0
while (counter <= nrow){
  CityName <- gsub(' ','%20',miasta$City[counter]) #remove space for URLs
  CountryCode <- "PL"
  url <- paste(
    "http://nominatim.openstreetmap.org/search?city="
    , CityName
    , "&countrycodes="
    , CountryCode
    , "&limit=9&format=json"
    , sep="")
  x <- fromJSON(url)
  if(is.vector(x)){
    miasta$lon[counter] <- x[[1]]$lon
    miasta$lat[counter] <- x[[1]]$lat    
  }
  counter <- counter + 1
}



rodzajZanieczyszczenia = "no2"


##przygotowanie danych dla danego zanieczyszczenia i danego roku

rodzajZanieczyszczenia_2019 <- rok2019 %>% filter(Country == c("PL")) %>% filter(Specie == rodzajZanieczyszczenia) %>% group_by(City) %>% summarise(mean2019 = mean(median))
rodzajZanieczyszczenia_2020 <- rok2020 %>% filter(Country == c("PL")) %>% filter(Specie == rodzajZanieczyszczenia) %>% group_by(City) %>% summarise(mean2020 = mean(median))
rodzajZanieczyszczenia_2018 <- rok2018 %>% filter(Country == c("PL")) %>% filter(Specie == rodzajZanieczyszczenia) %>% group_by(City) %>% summarise(mean2018 = mean(median))
rodzajZanieczyszczenia_2017 <- rok2017 %>% filter(Country == c("PL")) %>% filter(Specie == rodzajZanieczyszczenia) %>% group_by(City) %>% summarise(mean2017 = mean(median))
rodzajZanieczyszczenia_2016 <- rok2016 %>% filter(Country == c("PL")) %>% filter(Specie == rodzajZanieczyszczenia) %>% group_by(City) %>% summarise(mean2016 = mean(median))



# utworzenie z tego jednej ramki danych
df <- merge(miasta, rodzajZanieczyszczenia_2016)
df <- merge(df, rodzajZanieczyszczenia_2017)
df <- merge(df, rodzajZanieczyszczenia_2018)
df <- merge(df, rodzajZanieczyszczenia_2019)
df <- merge(df, rodzajZanieczyszczenia_2020)



# poprawa niektorych wspolrzednych miast, roznice sa niewielkie, ale gdzieniegdzie podpisy nachodzily na barploty

#Gdansk
df$lat[df$City == "Gdańsk"] <- 54.2143405

#Plock
df$lat[df$City == "Płock"] <- 52.645347099999996
df$lon[df$City == "Płock"] <- 	20.093630138580008

#Kielce
df$lat[df$City == "Kielce"] <- 51.05403585	
df$lon[df$City == "Kielce"] <- 20.799914352101452

#Warsaw
df$lon[df$City == "Warsaw"] <- 21.1067249


#Tarnow
df$lon[df$City == "Tarnów"] <- 21.36405842696229





## rysowanie na mapie

# funkcja do rysowania barplotow
mapbars <- function (x, xllc = 0, yllc = 0, barwidth=1, maxheight=10){
  
  #ogarniecie wysokosci dla danego barplota
  maksZeWszystkich = maksZeWszystkich = max(df%>% select(4:8))
  bars <- (x/maksZeWszystkich) * maxheight
  
  
  col <- brewer.pal(5, "PRGn")
  
  for(i in 1:length(x)){
    # ogarniecie wspolrzednych
    leftx   <- xllc + ((i-1) * barwidth) -(2.5*barwidth)
    rightx  <- leftx + barwidth
    bottomy <- yllc
    topy    <- yllc + bars[i]
    # draw the bar
    polygon(x=c(leftx, rightx, rightx, leftx, leftx),
            y=c(bottomy, bottomy, topy, topy, bottomy),
            col=col[i])
  }
}




# szkielet mapy

data("wrld_simpl")
Poland <- subset(wrld_simpl, NAME=="Poland")

plot(Poland, axes=FALSE)


df <- df %>% filter(City!= "Katowice" & City != "Rybnik")


for(i in 1:nrow(df)){
  if(df[i, 1]=="Katowice") next
  if(df[i, 1]=="Rybnik") next
  
  mapbars(x = c(df[i,4],df[i,5],df[i,6],df[i, 7], df[i, 8]), xllc=as.numeric(df[i, 2]), yllc=as.numeric(df[i, 3]) , barwidth=.17, maxheight=0.95 )
}


# estetyka
title(main = "Nitrogen dioxide (NO2) pollution in Poland", cex.main=3, adj = 0.5, line = -1)

#podpisy miast
text(as.numeric(df$lon), as.numeric(df$lat)-0.095, as.character(df$City) , cex = 2)


# plotowanie legendy
tutaj <- legend("bottomleft", inset=-.01, title="Mean of daily median in year",
                c("2016","2017","2018",   "2019", "2020"), fill=brewer.pal(5, "PRGn") , y.intersp = 0.7, horiz=TRUE, cex = 1.5, x.intersp = 0.2, text.width = 0.5, title.adj = 0.6, box.lwd=2, bty = 'n')


legend(x=c(tutaj$rect$left+0.4, tutaj$rect$left+tutaj$rect$w+0.3), y=c(tutaj$rect$top - 0.29, 
                                                                       tutaj$rect$top-tutaj$rect$h + 0.2) , legend = "")

legend(x=c(tutaj$rect$left, tutaj$rect$left+tutaj$rect$w), y=c(tutaj$rect$top, 
                                                               tutaj$rect$top-tutaj$rect$h), title="Mean of daily median in year",
       c("2016","2017","2018",   "2019", "2020"), fill=brewer.pal(5, "PRGn") , y.intersp = 0.7, horiz=TRUE, cex = 1.5, x.intersp = 0.2, text.width = 0.5, title.adj = 0.12, box.lwd=2, bty = 'n')





#Jeszcze legenda do slupkow
dla_no2 <- c(5,10,15)
dla_pm10 <- c(15, 30, 45)


barwidth=.17
maxheight=0.95


#funckja rysujaca legende dla slupkow z podpisami i jednostka
rysuj <- function(wyskosci){
  
  legend(x=c(tutaj$rect$left+0.4, (13.5 + (0.6*2) + 3*barwidth + ( 13.5 - (tutaj$rect$left+0.4)))+0.4  ), y=c(tutaj$rect$top - 0.29, 51.09) , legend = "")
  
  
  bars <- (wyskosci/max(wyskosci)) * maxheight
  
  for(i in 1:length(wyskosci)){
    # figure out x- and y coordinates for the corners
    leftx   <- 13.45 + 0.6*(i-1)
    rightx  <- leftx + barwidth
    bottomy <- 50
    topy    <- bottomy + bars[i]
    # draw the bar
    col <- brewer.pal(5, "PRGn")
    polygon(x=c(leftx, rightx, rightx, leftx, leftx),
            y=c(bottomy, bottomy, topy, topy, bottomy),
            col=col[3], border = "black")
    text( (leftx+rightx)/2, bottomy - 0.2, wyskosci[i],cex = 1.8)
  }
  
  text(  (leftx+rightx)/2 +0.68, bottomy - 0.2, "[AQI]",cex = 1.6   )
  
}

#wywolanie rodzajZanieczyszcznia no2, trzeba zamienic na pm10 adekwatnie
rysuj(dla_no2)

