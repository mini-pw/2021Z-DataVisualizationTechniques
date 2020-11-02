library(ggplot2)
library(SmarterPoland)
library(dplyr)

data("countries")
head(countries)

# Skale (scale)
p <- ggplot(data = countries, aes(x = continent, fill = continent)) +
  geom_bar()
p

p + scale_x_discrete(position = "top")
p + scale_y_continuous(position = "right")

continent_order <- countries %>%
  group_by(continent) %>%
  summarise(count = length(continent)) %>%
  arrange(desc(count)) %>%
  pull(continent)

p + scale_x_discrete(limits = continent_order)

p + scale_y_continuous(limits = c(-50, 100))
p + scale_y_reverse()
p + scale_y_sqrt()

p + scale_fill_manual(values = c("red", "grey", "black", "navyblue", "green"))
p + scale_fill_manual(values = rainbow(5))

# color brewer http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
#alternatywnie
library(RColorBrewer)
RColorBrewer::brewer.pal(n = 5, name = "Blues")

p <- ggplot(countries, aes(x = birth.rate, y = death.rate, color=death.rate)) +
  geom_point(size = 3)
p

p + scale_color_gradient(low = "navyblue", high = "red")
p + scale_color_gradient2(low = "navyblue", high = "red", mid = "white", midpoint = 8)



# Legenda

p <- ggplot(data = countries, aes(x = continent, fill = continent)) +
  geom_bar()
p

p + theme(legend.position = "bottom")
p + theme(legend.position = "none")
p + theme(legend.title = element_blank())
p + theme(legend.title = element_text(color = "blue"),
          legend.text = element_text(color = "red"))

p + labs(fill = "CONTINENT", x = "CONTINENT", y = "COUNT")
p + scale_fill_discrete(labels = letters[1:5])

p + ggtitle("TYTUL")

# Koordynaty (coord)

p
p + coord_flip()
p + coord_flip() + 
  scale_y_reverse()

p + scale_y_reverse() + 
  coord_flip()

p + coord_polar()

ggplot(countries, aes(x = birth.rate, y = death.rate, color = continent)) +
  geom_point() +
  coord_polar()

# Skórki (theme)

p + theme_bw()
p + theme_dark()

library(ggthemes)

p + theme_tufte()
p + theme_economist()
p + theme_void()


# Panele (facet)

set.seed(12312341)
small_diamonds <- diamonds[sample(1:nrow(diamonds), 500), ]

head(diamonds)
p <- ggplot(small_diamonds, aes(x=cut, y = price)) + 
   geom_boxplot()

p + facet_wrap(~clarity)

p + facet_wrap(~clarity, scales = "free_y")

p + facet_wrap(~clarity, scales = "free_x")

p + facet_wrap(~clarity + color)

p + facet_wrap(clarity, nrow = 1)


