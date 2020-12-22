library(gganimate)
library(sp)

x = seq(1,3*pi,by=pi/100)

choinka <- data.frame(x = x,
                 y = cos(50*(x))*x)
p1 <- runif(1000,-10,-3*pi)
p2 <- runif(1000,-2.5,2.5)

pien <- data.frame(p1,p2)

y_cords <- c(-8,0,8)
x_cords <- c(-3*pi,-1,-3*pi)
pol <-Polygon(cbind(x_cords,y_cords))

bombki <- data.frame(spsample(pol,n= 60,"random"),t = rep(1:3,60))
bombki2 <- data.frame(spsample(pol,n=60,"random"),t = rep(1:3,60))

r<- ggplot(data = NULL)+
  geom_line(data = choinka,aes(x=-x,y=y),col = "green")+
  coord_flip()+
  geom_point(data=pien,aes(x =p1,y= p2),col="brown")+
  geom_point(data=bombki,aes(x=x,y=y),col="red")+
  geom_point(data=bombki2,aes(x=x,y=y),col="yellow")+
  theme_minimal()

r+transition_reveal(t)
