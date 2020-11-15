library(dplyr)
library(ggplot2)


dane <- data.frame(
  gospodarstwa=rep(c("jednoosobowe", "wieloosobowe"), 6),
  miejsce=rep(c("Ogółem2002", "Ogółem2011", "Miasto2002", "Miasto2011", "Wieś2002", "Wieś2011"), each=2),
  len=c(93.5, 6.5, 88, 12, 94, 6, 89, 11, 93.3, 6.7, 86, 14), 
  stringsAsFactors = FALSE)

dane$miejsce = factor(dane$miejsce, 
                      levels = c("Ogółem2002", "Ogółem2011", "Miasto2002", "Miasto2011", "Wieś2002", "Wieś2011"))


ggplot(data = dane, aes(x=miejsce, y = len, fill=gospodarstwa))+
  geom_bar(stat="identity", position = position_stack(reverse = TRUE), width = 0.7) + 
  ylab("") + 
  annotate(geom = "text", x = 1.5 + 3 * (0:2), y = -18, label = c("Ogółem", "Miasta", "Wieś"), size = 5) + 
  coord_cartesian(ylim = c(0, 100), clip = "off") +
  xlab(" ") + 
  scale_fill_manual(values = c('#377eb8','#e08214')) + 
  labs(title = "Gospodartstwa domowe nierodzinne") + 
  scale_x_discrete(limits = c("Ogółem2002", "Ogółem2011", "Ogółem", "Miasto2002", "Miasto2011", "Miasto", "Wieś2002", "Wieś2011"),
                   breaks = c("Ogółem2002", "Ogółem2011", NA, "Miasto2002", "Miasto2011", NA, "Wieś2002", "Wieś2011"),
                   labels = c("2002", "2011", "", "2002", "2011", "", "2002", "2011")) +
  scale_y_continuous(breaks = seq(0, 100, 20), 
                     labels = paste(seq(0, 100, 20), "%", sep = "")) +
  theme_bw() +
  theme_light() + 
  theme(panel.grid.major.x = element_blank(),
        axis.line = element_line(colour = "grey"), 
        panel.grid.major.y = element_line(colour = "grey"), 
        panel.grid.minor.y = element_line(colour = "grey"), 
        plot.title = element_text(size = 18, hjust = 0.5), 
        axis.text.x = element_text(colour = "black", size = 12), 
        axis.text.y = element_text(colour = "black", size = 12), 
        legend.position = "top", 
        legend.title = element_blank(), 
        legend.text = element_text(size = 12), 
        axis.title.x = element_text(size = 30))

