library('ggplot2')
library('gganimate')

x1 <- runif(60,1,5)
y1 <- runif(60,1.25,2.5)
x2 <- runif(40,2,4)
y2 <- runif(40,2.5,3.75)
x3 <- runif(60,1.5,4.5)
y3 <- runif(60,4,5.25)
x4 <- runif(40,2.5,3.5)
y4 <- runif(40,5.25,6.5)
x5 <- runif(60,2,4)
y5 <- runif(60,7,8.25)
x6 <- runif(20,2.75,3.25)
y6 <- runif(20,8.25,9.25)

bombki <- data.frame(x = c(x1,x2,x3,x4,x5,x6),
                     y = c(y1,y2,y3,y4,y5,y6),
                     color = rep(c('red','blue', 'orange','green'),length.out=280))

p <- data.frame(x=c(2.5,3.5,3.5,2.5),y=c(0,0,1,1))
i1 <- data.frame(x=c(3,0,6),y=c(5,1,1))
i2 <- data.frame(x=c(3,0.5,5.5),y=c(8,4,4))
i3 <- data.frame(x=c(3,1,5),y=c(10,7,7))
g <- data.frame(x=c(3),y=c(10))

ggplot(bombki, aes(x=x,y=y)) +
  geom_polygon(data = p, aes(x=x,y=y), fill="brown") +
  geom_polygon(data = i1, aes(x=x,y=y), fill="darkgreen") +
  geom_polygon(data = i2, aes(x=x,y=y), fill="darkgreen") +
  geom_polygon(data = i3, aes(x=x,y=y), fill="darkgreen") +
  geom_point(data = g, aes(x=x,y=y),color='yellow',shape=8,size=10) +
  coord_equal() +
  theme_void() +
  theme(panel.background = element_rect(fill = "darkblue"),
        legend.position = 'none') +
  geom_point(aes(x=x,y=y,color=color), size=3) +
  transition_states(color,transition_length = 1,state_length = 1)
