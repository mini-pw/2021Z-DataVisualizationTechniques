library(gganimate)
library(data.table)
library(RColorBrewer)
library(gifski)



x <- seq(from =-2, to = 2, length.out = 100)
a = seq(from = 4, to =0, length.out = 100)
c = seq(from = 16,to = 0,length.out = 100)


hfun <- function(a,c,x){a*(-x*x)+c}

choinka <- data.frame(x,hfun(a[1],c[1],x))

plot <- ggplot(data = choinka, aes(x=x,y=hfun(a[1],c[1],x),color = "darkgreen")) + theme_void() + xlim(-3,3) + ylim(-2,16)

for(i in 1:100){
  choinka <- data.frame(x,hfun(a[i],c[i],x))
  plot <- plot + geom_point(data = choinka, aes_string(x=x,y=hfun(a[i],c[i],x)),colour = "darkgreen",size = 3,inherit.aes = FALSE)
  
}

trunk_x <- c(-0.5,0.5,0.5,-0.5)
trunk_y <- c(-2,-2,-0.15,-0.15)
trunk <- data.frame(trunk_x,trunk_y)

kol = rep(c("blue","red","yellow","pink","orange","black"),10)

bombki1 <-data.frame(x = seq(-1,-1,length.out = 15),y = seq(0.2,0.4,length.out = 15))
bombki2 <- data.frame(x = seq(-0.5,0.5,length.out = 13),y = seq(4,12,length.out = 13))
bombki3 <- data.frame(x = seq(-1.5,1.5,length.out = 16),y = seq(3,6,length.out = 16))
bombki4 <- data.frame(x = seq(-1.5,0.75,length.out = 16),y = seq(0,14,length.out = 16))
bombki <- rbind(bombki1,bombki2,bombki3,bombki4)






plot + geom_polygon(data = trunk, aes(x=trunk_x,y=trunk_y), fill="brown") +
  geom_point(bombki, mapping=aes(x=x, y=y, colour=kol), size=4) +
  theme(panel.background = element_rect(fill = "lightblue"),legend.position = 'none') +
  transition_states(kol,transition_length = 1,state_length = 1, wrap=TRUE)+
  exit_fade()+
  enter_fade()

animate(plot, duration = 8, fps = 60,renderer = gifski_renderer())
anim_save("tree.gif")
