library(dplyr)
library(hms)
library(ggthemes)


df <- read.csv('data/converted_data.csv')
df$update_time <- as.Date(df$update_time)
df$asleep <- as_hms(as.character(df$asleep))

df$dayofweek <- format(df$update_time,
                       "%a")
df$dayofweek <- plyr::revalue(df$dayofweek, c("śr."="sr.")) # bez tego: error input string 1 is invalid UTF-8

df$dayofweekfull <- format(df$update_time,
                           "%A")


df$tooltip_plot3_name = paste0("Imię: ", df$name, "\n","Liczba kroków: ", df$step_count, "\n",
                          "Jakość snu: ", paste(df$jakosc_snu*100), "%", "\n",
                          "Data: ", format(df$update_time, "%d-%m-%Y",),
                          ifelse(df$przebiegniete, paste0("\nCzas przebiegniecia 2km: ",
                                                          substring(df$czas, 4, 8)),""))
df$tooltip_plot2_name = paste0("Imię: ", df$name, "\n","Wskaźnik wyspania: ", round(df$Feelings, digits=2),
                          "\n","Spalone kalorie: ", round(df$calorie, digits = 0),"\n",
                          "Data: ", format(df$update_time, "%d-%m-%Y",), 
                          ifelse(df$przebiegniete, paste0("\nCzas przebiegniecia 2km: ",
                                                          substring(df$czas, 4, 8)),""))
df$tooltip_plot45_name = paste0("Imię: ", df$name, "\n","Długość snu: ", df$asleep,
                           "\n","Jakość snu: ", paste(df$jakosc_snu*100), "%", "\n",
                           "Data: ", format(df$update_time, "%d-%m-%Y",), 
                           ifelse(df$przebiegniete, paste0("\nCzas przebiegniecia 2km: ",
                                                           substring(df$czas, 4, 8)),""))
df$tooltip_plot3_update_time = df$tooltip_plot3_name
df$tooltip_plot2_update_time = df$tooltip_plot2_name
df$tooltip_plot45_update_time = df$tooltip_plot45_name

df$tooltip_plot3_dayofweek = paste0(df$tooltip_plot3_name, "\n",
                                    "Dzień tyg.: ", df$dayofweekfull)
df$tooltip_plot2_dayofweek = paste0(df$tooltip_plot2_name, "\n",
                                    "Dzień tyg.: ", df$dayofweekfull)
df$tooltip_plot45_dayofweek = paste0(df$tooltip_plot45_name, "\n",
                                    "Dzień tyg.: ", df$dayofweekfull)


legend_data <- data.frame(x = c(0,0), y = c(2, 6), shape = c("Nie", "Tak"),
                          przebiegniete = c(0, 1))


color.names <- c(
  "Adrian" = "#339999",
  "Ada" = "#F87060",
  "Karol" = "#B3A394"
)

# plots and tab background color (kolor tła całości trzeba też zmienić w UI)
background_color = '#d4d2cf'

tooltip_css <- "font-family: Arial,sans-serif;color:black;font-style:italic;padding:10px;border-radius:10px 20px 10px 20px;"

# for slider (czerwony kolor jesli wiecej dni jest w ktore sie nie biega, bialy 
#             jak po rowno i niebieski jak wiecej dni z bieganiem), kolorystyka ew do zmiany
colorfunc <- colorRampPalette(c("red", "yellow", "white", "royalblue", "blue")) 





### ---- plot1 data ----

library(ggplot2)


circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

head <- circleFun(c(1,5),10,150)
eyeL <- circleFun(c(-2,6),1,50)
eyeP <- circleFun(c(2,6),1,50)
mouth <- circleFun(c(0,3.5),1,28)
mouth_happy <- tail(mouth,nrow(mouth)/2)
mouth_sad <- head(mouth,nrow(mouth)/2)
mouth_sad$y <- mouth_sad$y - 0.5
body <- data.frame(x=rep(1, 70),y=seq(from=0, to=-10, length.out = 70))
legL <- data.frame(x=seq(from=-2, to=1, length.out = 50), y=seq(from=-13, to=-10, length.out = 50))
legP <- data.frame(x=seq(from=1, to=4, length.out = 50), y=seq(from=-10, to=-13, length.out = 50))
armL <- data.frame(x=seq(from=-3, to=1, length.out = 50), y=seq(from=-2, to=-4, length.out = 50))
armP <- data.frame(x=seq(from=1, to=5, length.out = 50), y=seq(from=-4, to=-2, length.out = 50))

skirt <- data.frame(x=c(
  seq(from=14,to=18,length.out = 25),
  seq(from=14,to=16,length.out = 25),
  seq(from=16,to=18,length.out = 25)
), y=c(
  rep(-10,25),
  seq(from=-10,to=-6,length.out = 25),
  seq(from=-6,to=-10,length.out = 25)
))
woman_body <- data.frame(x=rep(1, 30),y=c(seq(from=0, to=-6, length.out = 30)))


man1 <- rbind(head,eyeL,eyeP,body,legL,legP,armL,armP)
man1 <- man1 %>% 
  mutate(name = rep("Adrian",nrow(man1)))
mouth_happy_man1 <- mouth_happy %>% mutate(name = "Adrian")
mouth_sad_man1 <- mouth_sad %>% mutate(name = "Adrian")

man2 <- man1 %>% 
  mutate(x = x+30, name = rep("Karol",nrow(man1)))
mouth_happy_man2 <- mouth_happy %>% mutate(x = x+30, name = "Karol")
mouth_sad_man2 <- mouth_sad %>% mutate(x = x+30, name = "Karol")

woman <- rbind(head,eyeL,eyeP,woman_body,legL,legP,armL,armP) %>% 
  mutate(x = x+15)
woman <- rbind(woman, skirt)
woman <- woman %>% 
  mutate(name = rep("Ada",nrow(woman)))
mouth_happy_woman <- mouth_happy %>%mutate(x = x+15, name = "Ada")
mouth_sad_woman <- mouth_sad %>% mutate(x = x+15, name = "Ada")

people <- rbind(man1,man2,woman)

mouth_sad <- rbind(mouth_sad_man1, mouth_sad_woman, mouth_sad_man2)
mouth_happy <- rbind(mouth_happy_man1, mouth_happy_woman, mouth_happy_man2)

mouth_sad$happy = 0
mouth_happy$happy = 1

mouth <- rbind(mouth_sad, mouth_happy)

prostokaty <- data.frame(
  x = c(-5,-5,7,7,  -5+15,-5+15,7+15,7+15,   -5+30,-5+30,7+30,7+30),
  y = rep(c(-14,12,12,-14),3),
  name = rep(c("Adrian","Ada","Karol"),each=4)
)


rm(list = ls()[
  which(!(ls()%in%c("df", "color.names", "colorfunc",
                    "people", "prostokaty", "skirt", "mouth",
                    "background_color", "tooltip_css", "legend_data")))
]
)
label <- unique(format(df$update_time, "%a"))[c(2:7,1)]
data_weekdays <- data.frame(x = 1, y = seq(0, 7*3, length.out = 7),
                            label = rev(label))

data_weekdays$label <- as.character(data_weekdays$label)

dates <- as.Date(c("2020-12-20", "2021-01-15"))
dates <- seq(dates[1], dates[2], by = "day")

datespositions <- data.frame(update_time = dates,
                             x = c(1, rep(c(1, 3), each = 13)),
                             y = c(seq(12, 0, length.out = 13), -1,
                                   seq(12, 0, length.out = 13)))