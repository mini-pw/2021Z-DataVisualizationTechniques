library(dplyr)
library(ggplot2)
iris %>% filter(Petal.Width > 0.4) -> tmp
ggplot(tmp, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
