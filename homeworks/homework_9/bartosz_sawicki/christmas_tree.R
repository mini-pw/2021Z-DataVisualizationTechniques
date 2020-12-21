library(gganimate)
library(dplyr)
library(ggthemes)


df <- NULL
x <- 1
for (i in 1:15) {
  x <- c(0, x) + c(x, 0);
  y <- paste(x, collapse = " ")
  df = rbind(df,data.frame(row = i,
                           val = y, 
                           star_x = sample(c(runif(1,-0.2,-0.05),runif(1,0.05,0.2)),1),
                           star_y = runif(1,-4.5,0))) 
}

p <- ggplot(df)+
  geom_text(aes(label = val, y = -row * 0.7 , x = 0, group = seq_along(row)),
            color = '#0f8017',
            size = 4.5,
            fontface = 'bold') +
  geom_point(aes(x = star_x, y = star_y, group = seq_along(row)),shape = '*',size = 10, color = '#FFFFFF')+
  scale_y_continuous(limits = c(-12,0))+
  theme_tufte()+
  theme(plot.background = element_rect(fill = '#9dd9f5'),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        title = element_text(size = 20))+
  transition_reveal(row)

animate(p, fps = 60,nframes = 16, end_pause = 6)
anim_save('tree.gif')
