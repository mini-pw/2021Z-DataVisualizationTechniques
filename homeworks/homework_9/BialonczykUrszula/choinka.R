require(dplyr)
require(ggplot2)
require(ggimage)

trojkaty = data.frame(group = c(1,1,1), x = c(-1.5,1.5,0), y = c(0,0,1))
pien = data.frame(group = rep(3,4), x = c(-0.2, 0.2, 0.2, -0.2), y = c(0, 0, -0.3, -0.3))
pika = data.frame(x=0.1, y=2.68, pokemon = "pikachu")

lancuch_x = c(seq(-1.2, 1.2, 0.1), seq(-0.9, 0.9, 0.1), seq(-1, 1, 0.1), seq(-0.8, 0.8, 0.1), seq(-0.6, 0.6, 0.1), seq(-0.7, 0.7, 0.1),
              seq(-0.5, 0.5, 0.1), seq(-0.4, 0.4, 0.1), seq(-.5, .5, 0.1), seq(-0.4, 0.4, 0.1), seq(-0.2, 0.2, 0.1))
lancuch_y = c(rep(0.14, 25), rep(0.3, 19), rep(0.6, 21), rep(0.75, 17), rep(0.9, 13), rep(1.15, 15), 
              rep(1.3, 11), rep(1.5, 9), rep(1.73, 11), rep(1.88, 9), rep(2.1, 5))
lancuch_pok= c(rep("geodude", 25), rep("haunter", 19), rep("rattata", 21), rep("geodude", 17), rep("haunter", 13), rep("rattata", 15), 
               rep("geodude", 11), rep("haunter", 9), rep("rattata", 11), rep("geodude", 9), rep("haunter", 5))

lancuch = data.table::data.table(lancuch_x, lancuch_y, lancuch_pok)

p = ggplot() + 
  geom_polygon(data=trojkaty, aes(x=x, y=y, group=group, fill=as.factor(group))) +
  geom_polygon(data=mutate(trojkaty, y=y+0.5, x=x*0.8), aes(x=x, y=y, group=group, fill=as.factor(group))) +
  geom_polygon(data=mutate(trojkaty, y=y+1, x=x*0.64), aes(x=x, y=y, group=group, fill=as.factor(group))) +
  geom_polygon(data=mutate(trojkaty, y=y+1.5, x=x*0.512), aes(x=x, y=y, group=group, fill=as.factor(group))) +
  geom_polygon(data=pien, aes(x=x, y=y, group=group, fill=as.factor(group))) + 
  expand_limits(y=c(0,3)) +
  scale_fill_manual(values=c("forestgreen","brown4")) +
  geom_pokemon(data=pika, aes(x=x, y=y, image=pokemon), by="height",size=0.2) +
  geom_pokemon(data=lancuch, aes(x=lancuch_x, y=lancuch_y, image=lancuch_pok)) +
  theme_classic()+
  theme(panel.background = element_rect(fill = "midnightblue")) +
  ggtitle("Pokemas tree") +
  theme(line = element_blank(),
        text = element_blank(),
        title = element_blank()) + 
  theme(legend.position = "none") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold"))
p


