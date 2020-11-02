library("ggplot2")
library(scales)
library(RColorBrewer)

pieChart1 <- function(){
  df <- data.frame(
    browser = c("Chrome", "Other", "FireFox", "IE"),
    number = c(61.2, 11.3, 15.5, 12.1))

  bp<- ggplot(df, aes(x="", y=number, fill=browser))+
    geom_bar(width = 1, stat = "identity")
  pie <- bp + coord_polar("y", start=0)
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=10, face="bold")
    )

  pie + scale_fill_brewer("Browsers") + blank_theme +
    theme(axis.text.x=element_blank()) + 
    labs(title = "Deskopt Browser Share Market 2016")
                                              
}

pieChart1()
#########################################

barChart1 <- function(){
df <- data.frame(
  browser = c("Chrome", "Other", "FireFox", "IE"),
  number = c(61.2, 11.3, 15.5, 12.1))

ggplot(data = df, aes(x = reorder(browser, -number), y = number)) +
  geom_col(fill = "deepskyblue4") +
  labs(title = "Deskopt Browser Share Market 2016",
       x = "Browsers" , y = "Percentage of Share Market")
}
barChart1()

#########################################

pieChart2 <- function(){
  df1 <- data.frame(
    commut = c("Drive", "Subway", "Bike", "Walk", "Carpool"),
    number = c(56, 34, 5, 3, 2))

  bp<- ggplot(df1, aes(x="", y=number, fill=commut))+
    geom_bar(width = 1, stat = "identity")
  pie <- bp + coord_polar("y", start=0)
  pie + scale_fill_brewer("Means of transport") + blank_theme +
    theme(axis.text.x=element_blank())+
    labs(title = "Commuting Preferences")
}

pieChart2()
#####################################################
barChart2 <- function(){
  df1 <- data.frame(
    commut = c("Drive", "Subway", "Bike", "Walk", "Carpool"),
    number = c(56, 34, 5, 3, 2))
  
  ggplot(data = df1, aes(x = reorder(commut, -number), y = number)) +
    geom_col(fill = "deepskyblue4") +
    labs(title = "Commuting Preferences",
         x = "Means of transport" , y = "Usage of Means of transport in %")
}

barChart2()
####################################################
pieChart3 <- function(){
  nb.cols <- 15
  mycolors <- colorRampPalette(brewer.pal(5, "Greens"))(nb.cols)

  df3 <- data.frame(
    regions = c("CIS/Baltic States", "Taiwan", "Africa", "China", "Western Europ", "United States", "Japan",
              "Central Europ", "Southeast Asia", "South Korea", "South America", "Mexico", "Indian Subcontinent",
              "Canada", "Middle East"),
    number = c(5/360, 6/360, 3/360, 102/360, 92/360, 44/360, 23/360, 16/360, 15/350, 13/360, 12/360, 10/360, 8/360,
             5/360, 6/360))

  bp<- ggplot(df3, aes(x="", y=number, fill=regions))+
    geom_bar(width = 1, stat = "identity")
  pie <- bp + coord_polar("y", start=0)
  blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=10, face="bold")
  )
  pie + scale_fill_manual(values = mycolors) + blank_theme +
    labs(title = "World consumption of nylon resins 2015")
}
pieChart3()
###################################################
barChart3 <- function(){
  df3 <- data.frame(
    regions = c("CIS/Baltic States", "Taiwan", "Africa", "China", "Western Europ", "United States", "Japan",
                "Central Europ", "Southeast Asia", "South Korea", "South America", "Mexico", "Indian Subcontinent",
                "Canada", "Middle East"),
    number = c(5/3.6, 6/3.60, 3/3.60, 102/3.60, 92/3.60, 44/3.60, 23/3.60, 16/3.60, 15/3.60, 13/3.60, 12/3.60, 10/3.60, 8/3.60,
               5/3.60, 6/3.60))
  
  ggplot(data = df3, aes(x = reorder(regions, -number), y = number)) +
    geom_col(fill = "deepskyblue4") +
    labs(title = "World consumption of nylon resins 2015",
         x = "Regions" , y = "World consumption of nylon resins in %") +
    theme(axis.text.x  = element_text(size=7, angle=30))
}
barChart3()

###################################################

pieChart4 <- function(){
  nb.cols <- 7
  mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(nb.cols)

  df4 <- data.frame(
    Firmy = c("Firma A", "Firma B", "Firma C",  "Firma D",  "Firma E", "Firma F", "Pozostałe"),
    number = c(22,15,35,5,3,8,12))

  bp<- ggplot(df4, aes(x="", y=number, fill=Firmy))+
    geom_bar(width = 1, stat = "identity")
  pie <- bp + coord_polar("y", start=0)

  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=10, face="bold")
    )
  pie + blank_theme + scale_fill_manual(values = mycolors) +  
    labs(title = "Udział w rynku")
}
pieChart4()

##############################################################

barChart4 <- function(){
  f4 <- data.frame(
    Firmy = c("Firma A", "Firma B", "Firma C",  "Firma D",  "Firma E", "Firma F", "Pozostałe"),
    number = c(22,15,35,5,3,8,12))
  
  ggplot(data = df4, aes(x = reorder(Firmy, -number), y = number)) +
    geom_col(fill = "deepskyblue4") +
    labs(title = "Udział w rynku",
         x = "Firmy" , y = "Udział w rynku w %")
}
barChart4()

##################################################################

barChart5 <- function(){
  df5 <- data.frame(
    Firmy = c("Facebook", "Youtube", "Twitter",  "Reddit",  "Instagram", "Pinterest", "Linkedln", "Tumblr", "Yelp", "Quora"),
    number = c(39.14,25.12,6.28,4.83,2.17,2.15,1.45,1.22,0.79,0.75))
  
  ggplot(data = df5, aes(x = reorder(Firmy, -number), y = number)) +
    geom_col(fill = "deepskyblue4") +
    labs(title = "Market share of visits to social network sites in November, 2017",
         x = "social network sites" , y = "Market share in %")
}

barChart5()

#####################################################################

barChart6 <- function(){
  df6 <- data.frame(
    typ = c("Zawodowe", "Ogólnokształcące", "Zasadnicze",  "Gimnazja",  "Podstawowe"),
    number = c(717, 733, 229, 1529, 2485))
  
  ggplot(data = df6, aes(x = reorder(typ, -number), y = number)) +
    geom_col(fill = "deepskyblue4") +
    labs(title = "Uczniowe w szkołach",
         x = "rodzaj szkoły" , y = "liczba uczniów")
}

barChart6() 
