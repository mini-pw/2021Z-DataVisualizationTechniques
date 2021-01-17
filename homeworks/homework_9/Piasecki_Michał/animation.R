install.packages('gifski')
install.packages("sp")
install.packages("ramify")
install.packages('tidyverse')
library(ggplot2)
library(gganimate)
library(gifski)
library(sp)
library(tidyverse)




iso_triangle <- function(wide, height, xvertix, yvertix) {
  y <- c(rep(yvertix-height, 2), yvertix)
  x <- c(xvertix+wide/2, xvertix-wide/2, xvertix)
  data.frame(x, y)
}

square <- function(length, x_bottom_right, y_bottom_right) {
  x <- rep(c(x_bottom_right-length, x_bottom_right), 2)
  y <- rep(c(y_bottom_right, y_bottom_right+length), each = 2)
  data.frame(x, y)[c(1, 3, 4, 2), ]
}
snow_x <- rep(sample(-7:7,15)/2,10)
snow_y <- runif(150,0,8)
snow_y <- sort(snow_y, decreasing = TRUE)
time <- rep(seq(from=1,to=15,by=1),10)
time <- sort(time)
snow <- data.frame(snow_x, snow_y,time)
balls_x <- c(-2,2,0,-1,1,0,)
balls_y <- c(2,2,3,5,5,1)
balls <- data.frame(balls_x,balls_y)

tree <- ggplot() +
  aes(x, y) +
  geom_polygon(data = square(0.5, 0.25, 0.25), fill = "brown") +
  geom_polygon(data = iso_triangle(10, 4, 0, 4.5), fill = "darkgreen") + 
  geom_polygon(data = iso_triangle(9, 4, 0, 4.5), fill = "lightgreen") + 
  geom_polygon(data = iso_triangle(8, 3, 0, 6), fill = "green") +
  geom_polygon(data = iso_triangle(7, 3, 0, 6), fill = "darkgreen") +
  geom_polygon(data = iso_triangle(6, 2.5, 0, 7), fill = "lightgreen") + 
  geom_polygon(data = iso_triangle(5, 2.5, 0, 7), fill = "green") + 
  geom_polygon(data = iso_triangle(4, 1.5, 0, 7.5), fill = "darkgreen") +
  geom_polygon(data = iso_triangle(3, 1.5, 0, 7.5), fill = "lightgreen") +
  geom_polygon(data = iso_triangle(2, 1.5, 0, 8), fill = "green") +
  geom_point(data=balls,aes(x = balls_x,y = balls_y),color="red",size=6)+
  theme_void() +
  theme(plot.background = element_rect(fill = "black")) +
  geom_point(data=snow,aes(x = snow_x, y = snow_y),size = 4,color="white") + 
  transition_time(time) + 
  exit_shrink()
animate(tree, duration = 2, fps = 20, width = 300,height = 300, renderer = gifski_renderer())
anim_save("choinka.gif")

