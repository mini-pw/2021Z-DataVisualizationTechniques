library(gganimate)
library(ggplot2)
library(gifski)
library(sp)
library(dplyr)


set.seed(3)


#obrys choinki
y<-seq(0,10*pi, length.out = 10000)
x<-sin(y*1)*(10*pi-y)/3
df1 <- bind_cols("x"=x,"y"=y)
df2 <- bind_cols("x"=-rev(x), "y"=rev(y))
df <- bind_rows(df1,df2)


#punkty/bombki
punkty<-spsample(Polygon(df),20,"stratified")
punkty<-as.data.frame(punkty)
punkty$colorGroup <- sample(x = c("a", "b", "c"), size = nrow(punkty), replace = TRUE)


sniegX<-runif(50, min=-18, max=18)
sniegY<-runif(50, min=0, max=30)
dfSnieg=data.frame(sniegX= sniegX, sniegY = sniegY)


anim <- ggplot(df) + geom_point(dfSnieg, mapping=aes(x=sniegX,y=sniegY),color = 'white') + geom_path(aes(x = x, y =y), size=2, col = "darkgreen")+ geom_path(aes(x = x*0.75, y =y), size=2, col = "green")+ geom_path(aes(x = x*0.4, y =y), size=2, col = "darkgreen") + 
  geom_point(punkty,mapping=aes(x=x1,y=x2, fill=colorGroup,colour="black"), pch=21, size = 6) +
  theme_dark() + xlim(-20,20) +
  scale_fill_manual(values = c("cyan", "yellow", "firebrick1")) +
  
  theme(plot.background = element_rect(fill = '#8499ba'),
        
        panel.background = element_rect(fill = '#8499ba'),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        
        axis.line = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        
        legend.position = "None") +
  
        transition_states(colorGroup,
                    transition_length = 2,
                    state_length = 1) + enter_fade() + exit_shrink()




animate(anim, renderer = gifski_renderer(),fps = 30,nframes = 300)
anim_save("output.gif")
