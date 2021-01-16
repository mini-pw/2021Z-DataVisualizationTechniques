library("ggplot2")
library("ggimage")
library("dplyr")

set.seed(2020-12-21)
X= rnorm(800)
xmin = min(X)
xmax = max(X)

if(abs(xmin)>abs(xmax)){
  X=X*2/abs(xmin)
} else{
  X=X*2/abs(xmax)
}


d <- data.frame(x = X,
                y = c(runif(200),runif(200)+2,runif(200)+4,runif(200)+6),
                z = runif(800,-0.5,.5),
                v = runif(800,-2,0),
                image = sample(c(rep("greenstar.png",4),"goldstar.png"),
                               size=10, replace = TRUE)
)

ggplot(d, aes(x, y*abs(abs(x)-2)))+ geom_point(aes(z,v),color="brown") + geom_image(aes(image=image)) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none",
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())