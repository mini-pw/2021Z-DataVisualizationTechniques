library(ggplot)
library(SmarterPoland)
library(dplyr)



# 1. Stat i geom - roznice

ggplot(countries, aes(x = continent)) + 
  geom_bar()

ggplot(countries, aes(x = continent, y = death.rate)) + 
  stat_summary(fun = length, geom = "bar")

ggplot(countries, aes(x = continent, y = birth.rate)) + 
  stat_summary(fun = median, geom = "bar")

ggplot(countries, aes(x = continent, y = death.rate)) + 
  stat_summary(fun = median, geom = "point")

ggplot(countries, aes(x = continent, y = birth.rate)) + 
  geom_point(stat = "summary", fun = length) 



library(ggbeeswarm)
ggplot(countries, aes(x = continent, y = birth.rate)) + 
  geom_quasirandom(method = "smiley") 

ggplot(countries, aes(x = continent, y = birth.rate)) + 
  geom_quasirandom(method = "smiley") +
  stat_summary(fun = "mean", geom = "point", color = "red", size = 6)


ggplot(countries, aes(x = birth.rate)) + 
  geom_histogram()

ggplot(countries, aes(x = birth.rate)) + 
  stat_bin(geom = "bar")


# 2. Zaawansowane atrybuty ------------------------------ 
# wykresy gestosci bywaja czytelniejsze niz punktowe w przypadku duzej liczby punktow

ggplot(countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_point()

ggplot(countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_density_2d() +
  geom_point(color = "black", contour = TRUE)

# wykorzystujemy stat, a nie geom, poniewaz interesuje nas inna geometria (polygon)

ggplot(countries, aes(x = birth.rate, y = death.rate, fill = continent)) +
  stat_density2d(geom = "polygon") 

p <- ggplot(countries, aes(x = birth.rate, y = death.rate, fill = continent)) +
  stat_density2d(color = "black", geom = "polygon") 
p

df <- ggplot_build(p)
head(df$data[[1]])


ggplot(countries, aes(x = birth.rate, y = death.rate, fill = continent)) +
  stat_density2d(aes(alpha = ..level..), color = "black", geom = "polygon") 



# 4. Transformacje danych
# skrajne przypadki mozna podpisac

countries_labeled <- countries %>% 
  mutate(label_for_plot = ifelse(death.rate %in% c(min(death.rate), max(death.rate)),
                                 country, "")) 

ggplot(countries_labeled, aes(x = birth.rate, y = death.rate, label = label_for_plot)) +
  geom_point() +
  geom_text()

library(ggrepel)
ggplot(countries_labeled, aes(x = birth.rate, y = death.rate, label = label_for_plot)) +
  geom_point() +
  geom_text_repel()


# 3. wiele wykresow na jednym rysunku ---------------------------------------------------

library(gridExtra)

p <- ggplot(data = countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_point() +
  geom_smooth(se = FALSE)
p

grid.arrange(p + coord_cartesian(xlim = c(5, 10)) + ggtitle("coord_cartesian"),
             p + scale_x_continuous(limits = c(5, 10)) + ggtitle("scale_x_continuous - limits"),
             ncol = 1)

### wykresy gestosci brzegowych

main_plot <- ggplot(data = countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_point() 

density_death <- ggplot(data = na.omit(countries), aes(x = death.rate, fill = continent)) +
  geom_density(alpha = 0.2) +
  coord_flip() +
  scale_y_reverse() +
  theme(legend.position = "none")

density_birth <- ggplot(data = countries, aes(x = birth.rate, fill = continent)) +
  geom_density(alpha = 0.2) +
  scale_y_reverse() +
  theme(legend.position = "none")

grid.arrange(density_death, main_plot, density_birth, 
             ncol = 2)

library(grid)


grid.arrange(density_death, main_plot, rectGrob(gp = gpar(fill = NA, col = NA)), density_birth, 
             ncol = 2)

# zmiana wymiarow
grid.arrange(density_death, main_plot, rectGrob(gp = gpar(fill = NA, col = NA)), density_birth, 
             ncol = 2, heights = c(0.7, 0.3), widths = c(0.3, 0.7))

# przeniesienie legendy
grid.arrange(density_death, main_plot + theme(legend.position = "none"), rectGrob(gp = gpar(fill = NA, col = NA)), density_birth, 
             ncol = 2, heights = c(0.7, 0.3), widths = c(0.3, 0.7))

# konwersja obiektu ggplot na listę opisującą groby (graphical objects)
gtable <- ggplotGrob(main_plot)
gtable[["grobs"]]
gtable[["grobs"]][[1]][["name"]]

# funkcja wyjmujaca legende
get_legend <- function(gg_plot) {
  grob_table <- ggplotGrob(gg_plot)
  grob_table[["grobs"]][[which(sapply(grob_table[["grobs"]], function(x) x[["name"]]) == "guide-box")]]
}

grid.arrange(density_death, main_plot + theme(legend.position = "none"), 
             get_legend(main_plot), density_birth, 
             ncol = 2, heights = c(0.7, 0.3), widths = c(0.3, 0.7))

main_plot <- ggplot(data = countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_point() +
  theme_bw(base_size = 14) 


# Wyciagniety grob zachowuje wszelkie cechy wizualne, np theme
density_death <- ggplot(data = na.omit(countries), aes(x = death.rate, fill = continent)) +
  geom_density(alpha = 0.2) +
  scale_y_reverse() +
  coord_flip() +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") 

density_birth <- ggplot(data = countries, aes(x = birth.rate, fill = continent)) +
  geom_density(alpha = 0.2) +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") + 
  scale_y_reverse()

grid.arrange(density_death, main_plot + theme(legend.position = "none"), get_legend(main_plot), density_birth, 
             ncol = 2, heights = c(0.7, 0.3), widths = c(0.3, 0.7))

# Jak to zrobic latwiej?

library(patchwork)

p1 <- ggplot(data = countries, aes(x = continent, y = death.rate)) +
  geom_boxplot()

set.seed(1410)
p2 <- ggplot(data = countries, aes(x = continent, y = death.rate)) +
  geom_point(position = "jitter")

p3 <- ggplot(data = countries, aes(x = continent)) +
  geom_bar()

p1 + p2

p1 / p2

(p1 + p2) / p3

((p1 + p2) / p3) & theme_bw()

# rozklady brzegowe w patchwork
density_death + main_plot + plot_spacer() + density_birth + 
  plot_layout(ncol = 2, heights = c(0.7, 0.3), widths = c(0.3, 0.7))


# alternatywy do patchwork
# library(cowplot)
# library(customLayout)



