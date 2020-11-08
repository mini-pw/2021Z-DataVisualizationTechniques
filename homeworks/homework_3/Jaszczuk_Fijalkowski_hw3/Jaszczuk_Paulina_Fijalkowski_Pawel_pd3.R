library(ggplot2)
library(scales)
library(dplyr)
library(latticeExtra)

# reading data

data1 <- data.frame("color" = c("red", "blue", "yellow",
                               "pink", "black", "green",
                               "purple", "orange"),
                   "count" = c(18, 21, 9, 7, 11, 
                                    23, 4, 6))
                   
data2 <- read.table(text=' x   y     z
wiosna   32   grypa
wiosna   50   angina
wiosna   66   przeziebienie
lato   2   grypa
lato   23   angina
lato   12   przeziebienie
jesien  103   grypa
jesien  84   angina
jesien  122   przeziebienie
zima  43   grypa
zima  72  angina
zima  84   przeziebienie', header=TRUE)

# modyfying data

colors <-  droplevels(data1$color)
data1$color <- factor(colors, levels = c("red", "blue", "yellow",
                                        "pink", "black", "green",
                                        "purple", "orange"))

mycols <- c("red", "deepskyblue2", "gold", "violet", "black", "limegreen", "darkviolet", "darkorange")

# making plots

bar_plot <- function(data){
  ggplot(data, aes(x = color, y = count)) + 
    geom_bar(fill = 'navyblue', stat = 'identity') +
    ggtitle("What is people's favourite color?") +
    xlab("color") + ylab("count") +
    theme_bw() 
}

pie_plot <- function(data){
  ggplot(data, aes(x = "", y = count, fill = color)) +
    geom_bar(width = 1, stat = "identity", color = "gray50") +
    coord_polar("y", start = 0)+
    scale_fill_manual(values = mycols) +
    ggtitle("What is people's favourite color?") +
    theme_void()
}

plot_3d <- function(data){
  cloud(y~x+z, data, panel.3d.cloud=panel.3dbars, col.facet='grey', 
        xbase=0.4, ybase=0.4, scales=list(arrows=FALSE, col='black'), 
        par.settings = list(axis.line = list(col = "transparent")),  default.scales =
          list(distance = c(8, 8, 8), cex = 0.6), xlab = "", ylab = "",
        main = "Zachorowania w powiecie ³osickim w 2019 roku")
}

segment_plot <- function(data){
  ggplot(data, aes(x=z, y = y)) + 
    geom_bar(fill = 'navyblue', stat = "identity") +
    ggtitle("Zachorowania w powiecie ³osickim w 2019 roku") +
    xlab("") + ylab("liczba zachorowan") +
    facet_wrap(~x) 
}

