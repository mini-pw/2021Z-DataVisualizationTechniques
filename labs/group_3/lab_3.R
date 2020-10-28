library(ggplot2)
library(dplyr)
library(SmarterPoland)

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

orderContinent2 <- countries %>%
  group_by(continent) %>%
  summarise(count = length(continent)) %>%
  arrange(desc(count))

ggplot(data = orderContinent2, aes(x = reorder(continent, count), y = count, fill = continent)) +
  geom_bar(stat = "identity")



p + scale_x_discrete(limits = order_continent)

p + scale_y_continuous(limits = c(-50, 200))
p + scale_y_reverse()
p + scale_y_sqrt()

# nie dziala :(
# p + scale_x_reverse()

p + scale_fill_manual(values = rainbow(5))
p + scale_fill_manual(values = c('#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3'))
# alternatywnie
library(RColorBrewer)
RColorBrewer::brewer.pal(5, "Greens")

p <- ggplot(countries, aes(x = birth.rate, y = death.rate, color = death.rate)) + 
  geom_point(size = 4)
p

p + scale_color_gradient(low = "red", high = "black")
p + scale_color_gradient2(low = "red", high = "green", mid = "white", midpoint = 8)


# Legenda

p <- ggplot(data = countries, aes(x = continent, fill = continent)) +
  geom_bar()
p

p + theme(legend.position = "bottom")
p + theme(legend.position = "none")
p + theme(legend.title = element_text(color = "blue"))
p + theme(legend.title = element_text(color = "blue"),
          legend.text = element_text(color = "red"))
p + theme(legend.title = element_blank())

p + labs(fill = "LEGENDA", x = "KONTYNENT")
p + scale_x_discrete(name = "LEGENDA 2", labels = letters[1:5])
p + scale_fill_discrete(name = "LEGENDA 2", labels = letters[1:5])

p + ggtitle("NSUIGAS")

# Koordynaty (coord)

p

p + coord_flip()
p + coord_flip() + 
  scale_y_reverse()

p + scale_y_reverse() +
  coord_flip()

p + coord_polar()

# Skorki (themes)

p
p + theme_bw()
p + theme_dark()

library(ggthemes)
p + theme_tufte()
p + theme_void()
p + theme_excel()
p + theme_stata()

# Panele (facets)

head(diamonds)
small_diamonds <- diamonds[sample(1:nrow(diamonds), 400), ]

p <- ggplot(small_diamonds, aes(x = cut, y = price)) +
  geom_boxplot()
p

p + facet_wrap(~clarity)

p + facet_wrap(~clarity, scales = "free_x")

p + facet_wrap(~clarity, scales = "free_y")

p + facet_wrap(~clarity, scales = "free")


p + facet_grid(clarity ~ color)





