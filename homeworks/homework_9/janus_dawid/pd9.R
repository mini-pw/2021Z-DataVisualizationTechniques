install.packages('gifski')
install.packages('gif')
install.packages("ggstar")
library(gganimate)
library(ggstar)

pien_x<-c(rep(seq(2.3,2.7,length.out = 12),12))
pien_y<-c(rep(seq(0.5,1,length.out = 12),each=12))
pierwsza_x<-c(seq(1,4,length.out = 50))

a<-c(seq(1,4,length.out = 50))

for(i in 1:15){
  a<-a[c(-1,-length(a))]
  pierwsza_x<-c(pierwsza_x,a)
  
  
}

pierwsza_y<-c(rep(seq(1.05,2,length.out = 16),seq(50,20,by=-2)))


druga_x<-c(seq(1.5,3.5,length.out = 30))
a<-c(seq(1.5,3.5,length.out = 30))
for(i in 1:11){
  a<-a[c(-1,-length(a))]
  druga_x<-c(druga_x,a)
  
  
}

druga_y<-c(rep(seq(2.05,2.75,length.out = 12),seq(30,8,by=-2)))


trzecia_x<-c(c(seq(2,3,length.out = 16)))
a<-c(seq(2,3,length.out = 16))
for(i in 1:7){
  a<-a[c(-1,-length(a))]
  trzecia_x<-c(trzecia_x,a)
  
  
}

trzecia_y<-c(rep(seq(2.80,3.25,length.out = 8),seq(16,2,by=-2)))

gwiazda

x<-c(pien_x,pierwsza_x,druga_x,trzecia_x,2.49,1.3,1.8,1.4,1,3.7,3.2,3,1.2,3.6,3.9,1.6,2,3.4,2.6,2.1,2.8,1.5)
y<-c(pien_y,pierwsza_y,druga_y,trzecia_y,3.4,2.5,3,1.85,1.5,1.7,2.8,3.4,3.2,3.05,2.2,0.6,0.9,0.7,3,2.2,1.7,1.3)
kolor<-c(rep("pien",144),rep("choinka",590+198+72),"gwiazda", rep("snieżka",13),rep("bombki",4))
shape<-c(rep("zwykly",144+590+198+72),"gwiazda",rep("śnieżka",13),rep("z",4))
size<-c(rep("a",144+590+198+72),"b",rep("c",13),rep("d",4))
drzewo<-data.frame(x,y,kolor,shape,size)

p <- ggplot(drzewo) +
  geom_point(aes(x=x,y=y,colour = kolor,shape=shape,size=size)) + 
  scale_y_continuous(limits = c(0.5,3.5)) + scale_x_continuous(limits = c(0.5,4.5)) +
  scale_colour_manual(values=c("red","green","gold","saddlebrown","blue")) +theme_void()+ theme(legend.position = 'none') +
  scale_shape_manual(values = c("\u2605","\u2744","\u2603","\u25CF")) + scale_size_manual(values = c(3.2,20,6,12))
p


anim<-p + transition_time(x) + shadow_mark(past = T, future=F, alpha=1)
anim
anim_save("anim.gif", anim)
