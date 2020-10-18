library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

countries <- c('USA', 'Wielka Brytania', 'Niemcy', 'Hiszpania', 'Wlochy', 'Australia', 'Francja', 'Polska', 'Portugalia', 'Rumunia', 'Austria', 'Czechy', 'Holandia', 'Szwajcaria', 'Slowacja', 'Belgia', 'Izrael', 'Szwecja')
total_tests_per_country <- c(115347287, 26679020, 18129900, 13689776, 12197500, 7935463, 11900095, 3599722, 2764867, 2627544, 1756856, 1515912, 2656731, 1470894, 528367, 3545600, 426328, 1789328)
tests_per_million <- c(347922, 392435, 216200, 292768, 201821, 310224, 182201, 95483, 271371, 136837, 194765, 141483, 154954, 169617, 96764, 305393, 426328, 176874)
data <- data.frame(country = countries, total_tests = total_tests_per_country, tests_per_million = tests_per_million)

data <- data %>% 
  arrange(-total_tests)

countries_order <- rev(data$country)
data$country <- factor(data$country, levels = countries_order)

first_plot <- ggplot(data, aes(x = country, y = total_tests)) +
  geom_bar(stat = "identity", fill = 'deeppink4') +
  coord_flip() +
  ggtitle("Liczba wszystkich testów") +
  xlab("Panstwo") +
  ylab("Liczba testów") +
  ylim(c(0, 1.25 * 10^8))

sec_plot <- ggplot(data, aes(x = country, y = tests_per_million)) +
  geom_bar(stat = "identity", fill = 'deeppink4') +
  coord_flip() +
  ggtitle("Liczba testów na milion mieszkanców") +
  xlab("Panstwo") +
  ylab("Liczba testów")

plots <- ggarrange(first_plot, sec_plot, nrow = 2)
