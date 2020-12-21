library(dplyr)
library(rbokeh)
library(gganimate)
library(ggplot2)

x=runif(n = 10000, min = -1, max = 1)
y=runif(n = 10000, min = 0, max = 5)
p=data.frame(x,y)
t<- p %>% filter(y<5+5*x & y<5-5*x)
t500<- head(t,500)
grupa=rep(c("a","b","c","d","e"),100)

xt=t500["x"]
yt=t500["y"]


tre <- xt %>% mutate(yt)
tree <- tre %>% mutate(data.frame(grupa))


point_types()
pl <-figure() %>% ly_points(x,y,data=t,fill_color = "green")
pl








