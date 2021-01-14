library(ggplot2)
library(gganimate)

parabola <- function(x,n) {
  n*(abs(x/n)-1)**2
}
x1 <- seq(from=-3.4, to=0, by=0.2)
x2 <- seq(from=0, to=3.4, by=0.2)

x <- rep(c(x1,x2), times=4)
lenX1X2 <- length(c(x1,x2)) 
n <- rep(1:4, each=lenX1X2,times=4)
y <- parabola(x,n)
index <- rep(0:(length(x)/2-1), each=2)

tree <- data.frame(x,y,n,index)

p <- ggplot(tree, aes(x,y,group=n)) +
  geom_line(colour = "darkgreen") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_blank(),
        axis.title = element_blank()) +
        geom_point(aes(x=0,y=4), colour="yellow", size = 15, shape=8, position = "dodge")
  

p <- p + transition_reveal(index)

# animation_to_save <- p  + exit_shrink()
# anim_save("choinka.gif", animation = animation_to_save)
