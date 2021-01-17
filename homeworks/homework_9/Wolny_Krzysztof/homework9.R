
# LIBRARIES ---------------------------------------------------------------
library(dplyr)
library(ggplot2)
library("randomcoloR")
library("ggimage")

# DATA --------------------------------------------------------------------
## leaves
x <- runif(10000, min = -2, max = 2)
y <- runif(10000, min = -3, max = -3*abs(x) + 3 )

df_leaves <- data.frame(xl = x, yl = y)

## tree trunk
x <- runif(1000, min = -0.3, max = 0.3)
y <- runif(1000, min = -4, max = -3)

df_trunk <- data.frame(xt = x, yt = y)

## christmas baubles
x <- runif(400, min = -2, max = 2)
y <- runif(400, min = -3, max = 3)
rand_color <- randomColor(length(x), luminosity="light")

df_baubles <- data.frame(xb = x, yb = y, rand_color = rand_color)

df_baubles <- df_baubles%>%
  filter(yb <= -3*xb + 3 & y <= 3*xb + 3)
                        

## star
df_star <- data.frame(xs = 0, ys = 2.9)

## All
len_l <- length(df_leaves$xl)
len_t <- length(df_trunk$xt)
len_b <- length(df_baubles$xb)
kol_l <- rep("darkgreen", len_l)

df <- data.frame(state = c(rep(1, len_t+len_l), rep(2, len_b), 3), 
                 x = c( df_trunk$xt, df_leaves$xl, df_baubles$xb, df_star$xs), 
                 y = c(df_trunk$yt, df_leaves$yl, df_baubles$yb, df_star$ys), 
                 kol = c(rep("brown", len_t), kol_l, df_baubles$rand_color, 'yellow'), 
                 size = c(rep(2, len_t+len_l), rep(2, len_b), 10), 
                 shape = c(rep(16, len_t+len_l), rep(16, len_b), 8),
                 stroke = c(rep(0.7, len_t+len_l), rep(0.7, len_b), 3) 
                )

# CODE --------------------------------------------------------------------

ggplot(df,  aes(x = x, y = y)) + 
  geom_point(colour = df$kol, stroke = df$stroke, shape = df$shape, size = df$size) + 
  xlim(-3, 3) + 
  ylim(-4, 4) + 
  theme_void() + 
  theme(panel.background = element_rect(fill = "#A5ECFF", colour = "#A5ECFF"), 
        legend.position = "none") + 
  transition_layers(transition_length = 1)+
  enter_grow() +  
  exit_shrink() 
  
anim_save(filename = "christmas_tree", animation = last_animation())
