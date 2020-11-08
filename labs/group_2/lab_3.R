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

order_continent <- countries %>%
  group_by(continent) %>%
  summarise(count = length(continent)) %>%
  arrange(desc(count)) %>%
  pull(continent)

p + scale_x_discrete(limits = order_continent)
p + scale_y_continuous(limits = c(-100, 100))

p + scale_y_reverse()

# nie dziala :(
# p + scale_x_reverse()

p + scale_y_sqrt()

p + scale_fill_manual(values = c("green", "navyblue", "black", "grey", "red"))


# color brewer http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
p + scale_fill_manual(values = c('#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3'))

#alternatywnie
library(RColorBrewer)
RColorBrewer::brewer.pal(5, "Greens")

p + scale_fill_manual(values = rainbow(5))

# skala gradientowa
p <- ggplot(countries, aes(x = birth.rate, y = death.rate, color = death.rate)) +
  geom_point(size = 4)
p

p + scale_color_gradient(low = "navyblue", high = "red")

p + scale_color_gradient2(low = "navyblue", high = "red", mid = "white", midpoint = 8)

# Legenda

p <- ggplot(data = countries, aes(x = continent, fill = continent)) +
  geom_bar()
p

p + theme(legend.position = "bottom")
p + theme(legend.position = "none")
p + theme(legend.title = element_text(color = "green"),
          legend.text = element_text(color = "red"))
p + theme(legend.title = element_blank())

p + labs(x = "Continent AAAAA", fill = "NOWWY")
p + xlab("DSDAD")

p + scale_fill_discrete(name = "BBBB", labels = letters[1:5])

p + ggtitle("NOWY TYTUL") +
  theme(plot.title = element_text(hjust = 0.5))



# Koordynaty (coord)

p + coord_flip()

p + coord_flip() + scale_y_reverse()
p + scale_y_reverse() + coord_flip()
p + coord_polar()

p <- ggplot(data = countries, aes(x = birth.rate, y = death.rate, color = population)) +
  geom_point()
p + coord_polar()


# Skórki (theme)

p
p + theme_bw()
p + theme_dark()

library(ggthemes)

p + theme_tufte()
p + theme_void()
p + theme_excel_new()
p + theme_excel()

# Panele (facet)

set.seed(21321312)
head(diamonds)
small_diamonds <- diamonds[sample(1:nrow(diamonds), 500), ]

p <- ggplot(small_diamonds, aes(x = cut, y = price)) + 
  geom_boxplot()
p + facet_wrap(~clarity)
p + facet_wrap(~clarity, scales = "free_y")
p + facet_wrap(~clarity, scales = "free_x")
p + facet_wrap(~clarity, scales = "free")

p + facet_wrap(~ clarity + color)

p + facet_wrap(clarity ~ color)

p + facet_wrap(~clarity, nrow = 1)

