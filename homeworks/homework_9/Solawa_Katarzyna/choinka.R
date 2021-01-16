library(ggplot2)
library(dplyr)
library(gganimate)

y = c(0,0,
      0.5, -0.5,
      0.5, -0.5,
      4.5, -4.5,
      1.5, -1.5,
      4, -4,
      1,-1,
      3, -3,
      0.5, -0.5,
      2, -2,
      0,0)
x = c(1, 1,
      1,1,
      3,3,
      3, 3,
      5, 5,
      5,5,
      7,7,
      7,7,
      9,9,
      9,9,
      11,11)
index = c(0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10)
fact = c(0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1)

data = data.frame(x, y, index, fact)
data

p <- ggplot(
  data,
  aes(y, x, group = fact, col = factor((index)))
) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        legend.position = "none",
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_path() +
  scale_color_viridis_d() +
  xlim(-7,7)+
  ylim(0,12)
  
p
# p +geom_point(shape = 8)+ transition_reveal(index)



