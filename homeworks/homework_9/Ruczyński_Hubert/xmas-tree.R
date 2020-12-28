rm(list = ls())
library(ggplot2)
library(gganimate)
library(data.table)

x <- c(21,18,15,12,9,6,3,18,15,12,9,6,3,15,12,9,6,3,12,9,6,3,9,6,3,6,3,1)

dat1 <- data.frame(x1 = 1:length(x), x2 = x)
dat2 <- data.frame(x1 = 1:length(x), x2 = -x)
dat3 <- data.frame(x1 = 1:length(x), x2 = x)
dat4 <- data.frame(x1 = 1:length(x), x2 = -x)
dat1
dat2
#dat3=as.data.table(dat3, keep.rownames =TRUE)
#setnames(dat3,"id","x1","X2","xvar","siz","col")
#dat4=as.data.table(dat4, keep.rownames =TRUE)
#setnames(dat4,"id","x1","X2","xvar","siz","col")
dat1$xvar <- dat2$xvar <- NA
dat1$yvar <- dat2$yvar <- NA
dat1$siz <- dat2$siz <- NA
dat1$col <- dat2$col <- NA
dec_threshold = -10

set.seed(2512)
for (row in 1:nrow(dat1)-1){
  
  if (rnorm(1) > dec_threshold){
    
    dat1$xvar[row] <- row
    dat1$yvar[row] <- dat1$x2[row]-1
    dat1$siz[row] <- runif(1,2,3)
    ?runif
    dat1$col[row] <- sample(1:4, 1)
  }
  
  if (rnorm(1) > dec_threshold){
    
    dat2$xvar[row] <- row
    dat2$yvar[row] <- dat2$x2[row]+1
    dat2$siz[row] <- runif(1,2,3)
    dat2$col[row] <- sample(1:4, 1)
    ?sample
  }
}

anim <- ggplot() +
  geom_bar(data = dat1, aes(x=x1, y=x2, fill=x2),stat = "identity") +
  geom_bar(data = dat2, aes(x=x1, y=x2, fill=abs(x2)),stat = "identity") +
  geom_point(data = dat1,aes(x = xvar, y = yvar, size = siz, colour = as.factor(col)) ) +
  geom_point(data = dat2,aes(x = xvar, y = yvar, size = siz, colour = as.factor(col)) ) +
  scale_fill_gradient(low = "green", high = "darkgreen")+
  coord_flip() + theme_minimal()+ theme(legend.position="none",
                                        panel.grid = element_blank(),
                                        axis.title.x=element_blank(),
                                        axis.text.x=element_blank(),
                                        axis.ticks.x=element_blank(),
                                        axis.title.y=element_blank(),
                                        axis.text.y=element_blank(),
                                        axis.ticks.y=element_blank()) +
  ggtitle('X-mas Tree')+
  transition_states(abs(x2),1,1)+
  shadow_mark()+
  enter_fade()

anim
?anim_save
anim_save("x-mas_tree.gif", animation=anim)

