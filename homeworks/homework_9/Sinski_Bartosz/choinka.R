library(ggplot2)
library(gganimate)
library(ggthemes)
library(gifski)
x <-c()

y <- seq(-20,20,by=0.5)
z <- c()
for (i in 1:40){
  newx <- seq(y[i],y[81-i],by=0.5)
  x <- c(x,newx)
  z <- c(z,rep(2*i,length(newx)))
}
df = data.frame(z,x)
gwiazdkax = c(-0.25)
gwiazdaky = c(83)
df2 = data.frame(gwiazdkax,gwiazdaky)
logx= rep(seq(-2,2),15)
logy= rep(seq(0,-14),each=5)
df3 = data.frame(logx,logy)
bombkix = rep(c(0,-2,2,0,-5,4,-1,-8,7,8,3,-5,-13,-2,12,3,8,-3,-13,0.5,-9,-8),2)
bombkiy = rep(c(75,70,66,60,56,56,50,43,40,35,30,30,18,20,10,10,16,7,6,40,27,16),2)
kolor = 1:44
df4 = data.frame(bombkix,bombkiy,kolor)
animacja = ggplot() + geom_point(df,mapping = aes(x,z),shape=25,fill="green3",size = 3 ) + xlim(-30,30) + 
  geom_point(df2,mapping = aes(x = gwiazdkax,y=gwiazdaky),shape = 8,colour="yellow",size=5) + 
  geom_point(df3,mapping = aes(logx,logy),size=3.5,shape=15,colour="brown4") +
  geom_point(df4,mapping = aes(bombkix,bombkiy),size=5,colour=kolor) + transition_states(kolor,transition_length = 2,state_length = 1)+
  exit_fade()

animate(animacja)
anim_save("animacja.gif",animacja)

