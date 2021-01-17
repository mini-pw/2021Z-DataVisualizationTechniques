library(ggplot2)
library(gganimate)
library(dplyr)
library(gifski)

t <- seq(from = 0, to = 1, length.out = 10000)
r <- 3
h <- 5
helix <- r*(1-t)*cos(60*t)
helih <- h*t
data <- data.frame(helix, helih)

plot <- ggplot(data=data, aes(x=helix, y=helih)) + geom_point(shape = 17, size = 4, aes(colour = helih)) + 
  scale_color_gradient(low = "green4", high = "grey") + ggtitle("Merry Christmas!") +
  theme_void() + theme(plot.title = element_text(size=18, face="bold", hjust = 0.5)) +
  theme(legend.position = "none", panel.background = element_rect(fill = "#141852", colour = "#6D9EC1", size = 0, linetype = "solid"))

lights_num <- 314
lig_t <- seq(from = 0, to = 0.99, length.out = lights_num)
lig_x <- r*(1-lig_t)*cos(60*lig_t)
lig_h <- h*lig_t
lights <- data.frame(lig_x, lig_h, lig_t)

plot <- plot + geom_point(data = lights, aes(x=lig_x, y=lig_h, fill = as.factor(lig_t)), shape = 21, size = 2, alpha = 0.8) + 
  scale_fill_manual(values = rep(c("#00ff6f", "#ffa900", "#ff3217", "#3b77ff"), length.out = lights_num)) +
  labs(title = "Merry Christmas!", x = '', y = '') +
  transition_reveal(lig_h, keep_last = TRUE)

animate(plot, duration = 5, fps = 30, width = 1000, height = 1000, renderer = gifski_renderer())
anim_save("choinka.gif", plot)