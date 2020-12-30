library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(gganimate)
library(gifski)


abc <- c("a", "b", "c")
kolor <-append(rep(abc, 17), c("a", "b"))




df1 <- data.frame(x=seq(-2, 2, 0.5), y=seq(2, 3.6, 0.2))
df2 <- data.frame(x=rev(seq(-2, 2, 0.5)), y=rev(seq(3.6, 2, -0.2)))
df <- rbind(df1, df2)
df3 <- data.frame(x=seq(-2, 1, 0.5),y=seq(3.6,4.8,0.2))
df <- rbind(df, df3)
df4 <- data.frame(x=rev(seq(-1, 2, 0.5)),y=rev(seq(4.8,3.6,-0.2)))
df <- rbind(df, df4)
df5 <- data.frame(x=seq(-1, 1, 0.5),y=seq(5.6 ,4.8,-0.2))
df <- rbind(df, df5)
df6 <- data.frame(x=rev(seq(-1, 1, 0.5)),y=rev(seq(4.8,5.6,0.2)))
df <- rbind(df, df6)
df7 <- data.frame(x=seq(-2.5, 2.5, 0.5),y=c(1.5))
df <- rbind(df, df7)

df$kol <- kolor
 
colnames(df) <- c("x", "y", "kol")




h <- ggplot()+geom_polygon(aes(x=c(-1,1,1,-1),y=c(0,0,1,1)),fill="brown")+
  geom_polygon(aes(x=c(-3,3,1.5, -1.5 ),y=c(1, 1,3,3)),fill="forestgreen")+coord_equal()+
  geom_polygon(aes(x=c(-2.5,2.5 ,1.2, -1.2 ),y=c(3, 3,5,5)),fill="forestgreen")+
  geom_polygon(aes(x=c(-1.75,1.75 , 0 ),y=c(5, 5,7)),fill="forestgreen")+
  geom_text(aes(x=0,y=7),label="???", size=20, color="gold")+
  geom_point(df, mapping=aes(x=x, y=y, colour=kol), size=4)+
  scale_colour_manual(values=mypalette5) +
  theme_void()+
  theme(legend.position="none")+
  theme(panel.background = element_rect(fill = "lightblue"))

anim <- h + 
  transition_states(kol,transition_length = 1,state_length = 1, wrap=TRUE)+
  exit_fade()+
  enter_fade()






animate(anim, duration=2, renderer = gifski_renderer())
anim_save("choinka.gif")

