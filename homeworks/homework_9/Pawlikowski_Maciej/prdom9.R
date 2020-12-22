

library(gganimate)
library(ggplot2)
library(dplyr)
library("ggimage")
library(tibble)
valueadd=1:50
valueadd=valueadd^2
valueadd=c(valueadd/2,valueadd,valueadd*2)
value1=100-valueadd
value2=100+valueadd
y1=150:1
x=runif(75,-4500,4500)
xsnow=c(x,x)
y = runif(75,100,150)
ysnow=c(y,runif(75,0,100))
sn=c(rep('0',75),rep('1',75))
snowdata<-data_frame(value1 = value1,value2=value2,ysnow,xsnow,sn,
                     y1 = y1,
                     width = 20 * sample(seq(15, 30, length.out=length(value1))),
                     pie = list(pie))
dd <- data.frame(x=LETTERS[1:2], y=c(3,5))
pie <- ggplot(dd, aes(x=1, y, fill=x)) + geom_bar(stat="identity", width=1) + coord_polar(theta="y") +
  theme_void() + theme(legend.position="none") + theme_transparent()
df <- data_frame(value1 = value1,value2=value2,ysnow,xsnow,sn,
                 y1 = y1,
                 width = 20 * sample(seq(15, 30, length.out=length(value1))),
                 pie = list(pie))
df$random_number <- mapply(function(x, y) sample(seq(x, y), 1), 
                           df$value1, df$value2)
p <- ggplot(snowdata,
            aes(y = y1)) +
  labs(x = "Merry Christmas") +
  geom_segment(data=df,aes(x = value1,
                   y = y1,
                   xend = value2,
                   yend = y1),color='green',
               size = 1) + 
  theme(
    panel.grid.major =element_blank(),
    panel.grid.minor =element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    panel.background = element_rect(fill = "blue",
                                    colour = "blue",
                                    size = 0.5, linetype = "solid")) 
df<-df%>%
  filter((y1>0 & y1<=40)|(y1>50 & y1<=80)|(y1>100 & y1<=115)|(y1>117 & y1<=120)|(y1>125 & y1<=130))
r<-p +  geom_subview(aes(x=random_number, y=y1, subview=pie, width=width, height=width), data = df)
barx=c(0,0)
bary=c(1,-3)
bardata=data.frame(barx,bary)
s<-r+
  geom_bar(data=bardata,aes(x=barx,y=bary),stat="identity",fill="brown",width=1000)
presentsx=c(-3000,1500,4500,-3000,1500,4500)
presentsy=c(10,15,10,-3,-3,-3)
colorp=c("red","red","red","red","red","red")
colorw=c("yellow","yellow","yellow","yellow","yellow","yellow")

w1=c(3,5,3,3,3,3)
w2=c("red","red","red","yellow","yellow","yellow")
presents=data.frame(presentsx,presentsy,colorp,colorw,w1,w2)
t<-s+
  geom_bar(data=presents,aes(x=presentsx,y=presentsy),stat="identity",fill=colorp,width=1000)+
  geom_bar(data=presents,aes(x=presentsx,y=w1),stat="identity",fill=w2,width=1000)+
  geom_bar(data=presents,aes(x=presentsx,y=presentsy),stat="identity",fill=colorw,width=300)
u<-t+
  geom_point(color='snow', aes(x = xsnow, y = ysnow))
u

