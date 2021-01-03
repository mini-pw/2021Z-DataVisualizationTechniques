library(ggplot2)
library(gganimate)
library(ggimage)



d <-data.frame(x=c(8,4,12, 8,5,11, 8,6,10),
               y=c(6,1,1, 9,4,4, 11,7,7),
               t=c('a', 'a', 'a',  'b', 'b', 'b', 'c', 'c', 'c'),
               r=c(1,2,3, 4,5,6, 7,8,9))


balls <- data.frame(x=c(6,10,7.9,7.1,8.23,8.85,7.47,9.5,6),
                   y=c(2.17,1.7,3.23,6.13,4.73,7.87,9.1,5.3,4.6))

star <- data.frame(x=c(8), y=c(11))

snow <- data.frame(x=c(5,3.7,7.9,7,12,10,12.5,9.9,
                       10.11,7.57,6.83,12.87,12.23,9.5,5.8,4.31),
                   y=c(12.5,9.75,12.5,11,7.8,9.5,12,11.75,
                       1.53,1.81,5.63,2.81,1.83,5.27,1.59,4.69),
                   pos=as.factor(c('a','a','a','a','a','a','a','a',
                         'b','b','b','b','b','b','b','b')))


p <- ggplot(snow) +
  geom_polygon(data=d, mapping=aes(x=x, y=y, group=t), fill='#617b43', color='black')+
  geom_point(data = star, aes(x=x, y=y), shape=8, size= 14, color='yellow')+
  geom_point(data=balls,aes(x=x, y=y), size=5, color='#b15652')+
  geom_point(aes(x=x, y=y), shape=8, size= 5, color='white')+
  transition_states(pos, transition_length = 1.5, state_length = 0.1, wrap=FALSE)+
  theme_void()+
  theme(panel.background = element_rect(fill = '#2a586a'))

animation <- animate(p, nframes = 30, fps=20)

anim_save("choinka.gif", animation)
