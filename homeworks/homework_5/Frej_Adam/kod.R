library(dplyr)
library(ggplot2)

mezczyzni <- data_frame(c("Pełnozatrudenini", "Niepełnozatrudnieni",
                          "Pracujący\n na własny rachunek\n bez pracowników",
                          "Pomagający\n w rodzinie", "Pracodawcy",
                          "Nieustalony status"),
                        c(68.5, 14.4, 9.2, 6.9, 0.9, 0.1), c(1, 2, 3, 4, 5, 6))
mezczyzni <- rename(mezczyzni, argumenty = 1, wartosci = 2, kolejnosc = 3)

kobiety <- data_frame(c("Pełnozatrudenini", "Niepełnozatrudnieni",
                        "Pracujący\n na własny rachunek\n bez pracowników",
                        "Pomagający\n w rodzinie", "Pracodawcy",
                        "Nieustalony status"),
                        c(65.0, 22.8, 6.1, 5.3, 0.6, 0.2), c(1, 2, 3, 4, 5, 6))
kobiety <- rename(kobiety, argumenty = 1, wartosci = 2, kolejnosc = 3)

m_plot <- ggplot(mezczyzni, aes(x = reorder(argumenty, kolejnosc), y = wartosci)) +
  geom_bar(stat = "identity", fill = "brown") +
  labs(title = "Mężczyźni", x = "Status zatrudnienia", y = "Procent osób") +
  geom_text(aes(label=wartosci), vjust=-0.5)

k_plot <- ggplot(kobiety, aes(x = reorder(argumenty, kolejnosc), y = wartosci)) +
  geom_bar(stat = "identity", fill = "chocolate") +
  labs(title = "Kobiety", x = "Status zatrudnienia", y = "Procent osób") +
  geom_text(aes(label=wartosci), vjust=-0.5)

library(cowplot)

plot_grid(m_plot, k_plot)