library(ggplot2)
library(gganimate)
library(gifski)
library(data.table)


Data <- data.frame( Xx = sample(seq(-5,5,0.1), 180, replace = T), Yy = sample(seq(0,10,0.1), 180, replace = T), Ll = sample( c("red", "blue", "pink"),180, replace = T))
Bombas <- data.table(Xx = c(x=runif(21,-5,5),runif(21,-4,4),runif(21,-3,3),runif(21,-2,2)), 
                     Yy = c(rep(c(2,3.5,5,6.25), each = 21)), Ll = sample(c("red", "blue", "pink"), 21, replace = T))
                     
                     
p <- ggplot(Data, aes(Xx , Yy)) +
  geom_tile(data = data.frame(Yy= c(-0, 0, 2, 2), Xx = c(-0.3, 0.3, -0.3, 0.3)), fill = "tan3") +
  geom_polygon(data = data.table(Xx = c(-5,0,5),Yy =c(2,4,2)),fill = "palegreen3", col="palegreen4",lwd=3) +
  geom_polygon(data = data.table(Xx = c(-4,0,4), Yy= c(3.5,5.5,3.5)),fill="palegreen4",col="palegreen3",lwd=3) +
  geom_polygon(data = data.table(Xx = c(-3,0,3),Yy = c(5,6.5,5)),fill="palegreen3",col="palegreen4",lwd=3) +
  geom_polygon(data = data.table(Xx = c(-2,0,2),Yy = c(6.25,7.5,6.25)),fill="palegreen4",col="palegreen3",lwd=3) +
  geom_point(data = Bombas, colour = Bombas$Ll, size = 5, alpha = 0.5) + 
  geom_point(data = data.table(Xx = 0, Yy= 7.5), shape = 23, size = 15, colour = "#FFBF00", fill = "#FFBF00") + 
  geom_point(data = data.table(Xx = 0, Yy= 7.5), shape = 22, size = 15, colour = "#FFBF00", fill ="#FFBF00") + 
  annotate("text", x=0, y = 9, label = "Merry Xmas", size = 20, colour = "red", family = "serif") + 
  geom_point(aes(colour = Ll),size = 3, shape = 8, colour = "#FFF854") +
  theme_void() + theme(panel.background = element_rect(fill = "lightblue"))


p

anim <- p + transition_states(Ll,
                              transition_length = 0.1,
                              state_length = 1) 
  

anim
anim_save("Choinka")
