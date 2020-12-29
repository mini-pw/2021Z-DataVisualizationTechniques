library(dplyr)
library(ggplot2)
library(gganimate)
choina <- function(x) {
  x_loc <- x
  y_low <- min((ceiling(x_loc) - sqrt(ceiling(x_loc) - x_loc)), 
               (- sqrt(x_loc - floor(x_loc)) - floor(x_loc)))
  ifelse(x < 0,
         (ceiling(x_loc) - sqrt(ceiling(x_loc) - x_loc) - y_low),
         (- sqrt(x_loc - floor(x_loc)) - floor(x_loc) - y_low)
         )
}
under <- function(x, y) {
  choina(x) < y
}

under_categorize <- function(x, y) {
  ifelse(
    (0.5*x)^2 + (y-2.75)^2 < 0.0625,
    "star",
    ifelse(
      choina(x) < y,
      "sky", 
      ifelse(
        (abs(round(x*1) - x*1))^2 + (abs(round(y*2) - y*2))^2 < 1/64,
        "ornament", 
        "tree" 
      )
    )
  )
}
choina_reference <- function() {
  x <- seq(-3, 3, 0.01)
  bind_cols(x, choina(x)) %>% rename("x" = "...1", "y" = "...2") %>%
    ggplot(aes(x = x, y = y)) + 
    geom_line()
}

make_MC_df <- function(size, frame_count = 10) {
  x_p <- runif(size) * 6 - 3
  y_p <- runif(size) * 3
  #f_p <- (seq(0, size-1, 1) %/% (size%/%frame_count)) + 1
  f_p <- seq(1, size, 1)
  bind_cols(x_p, y_p, f_p) %>%
    rename("x"= "...1", "y" = "...2", "f" = "...3")
}

mc_df <- make_MC_df(25000) 
mc_df %>%
  mutate(u = under_categorize(x, y)) %>%
  ggplot(aes(x = x, y = y, color = u)) +
  geom_point(aes(group = f)) +
  theme_void() +
  scale_colour_manual(values = c("#4444FF", "#FFFF00", "#FF0000", "#00AA00"),
                      breaks = c("sky", "star", "ornament", "tree")) +
  theme(legend.position = "none") +
  ggtitle("Choinka Monte Carlo") +
  transition_reveal(f) -> 
  anim

anim

anim_save("choinka.gif", anim)
