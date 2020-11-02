library(ggplot2)

dane <- data.frame(rok = c("2001 i wcześniej", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010"),
                   liczba = c(279.4, 37.3, 48.9, 82.1, 162.4, 210.7, 201.7, 210.0, 234.7, 97.4))
total <- sum(dane$liczba)
                              
ggplot(dane)+
  geom_col(aes(x = rok, y = liczba), fill = "#6899d9")+
  scale_y_continuous(breaks = c(0, 50, 100, 150, 200, 250))+
  labs(y = "Liczba w tys.", title = "Emigranci przebywający za granicą czasowo 12 miesięcy i więcej według roku wyjazdu",
       x = NULL)+
  theme_bw()

# ggsave("poprawiony.png", dpi = 250, width = 30/1.5, height = 15/1.5, units = "cm")
