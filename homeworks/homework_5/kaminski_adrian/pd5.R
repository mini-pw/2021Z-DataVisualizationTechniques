library(ggplot2)
library(ggthemes)
library(dplyr)

values <- c(0.2,62.4,35.6,1.8,
            0.1,62.3,33.6,4.0)

gender <- rep(c("Mężczyźni", "Kobiety"), each=4)

fill <- rep(c("przedprodukcyjny", "produkcyjny mobilny", "produkcyjny niemobilny", "poprodukcyjny"),
            2)

df <- data.frame(values = values,
                 gender = gender,
                 fill = fill,
                 stringsAsFactors = FALSE)

ggplot(df, aes(x = factor(gender, levels = c("Mężczyźni", "Kobiety")), y=values, fill=fill)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label=values), position=position_dodge(width=0.9), vjust=-0.25, size=6) +
  scale_fill_manual(values = c('#1b9e77','#d95f02','#7570b3','#e7298a')) + 
  theme_hc() + 
  scale_y_continuous(breaks = seq(0, 80, by=10), limits = c(0,70)) +
  ylab("%") +
  ggtitle(expression(Struktura~pracujących~według~ekonomicznych~grup ~underline(wieku) ~i~ underline(płci))) +
  theme(
    axis.title.x = element_blank(),
    legend.title = element_blank(),
    axis.title.y = element_text(angle = 0,vjust = 0.5),
    plot.title = element_text(hjust = 0.5, size = 20, face="bold")
  ) -> a

a
ggsave("wykres1.jpeg", a)

df %>%
  group_by(fill) %>%
  summarise(mean = mean(values)) %>% 
  arrange(-mean) %>%
  pull(fill) -> fill_levels


ggplot(df, aes(x = factor(fill, levels = fill_levels), y=values,
               fill=factor(gender, levels = c("Mężczyźni", "Kobiety")))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label=values), position=position_dodge(width=0.9), vjust=-0.25, size=6) +
  scale_fill_manual(values = c('#1b9e77','#d95f02')) + 
  theme_hc() + 
  scale_y_continuous(breaks = seq(0, 80, by=10), limits = c(0,70)) +
  ylab("%") +
  ggtitle(expression(Struktura~pracujących~według~ekonomicznych~grup ~underline(wieku) ~i~ underline(płci))) +
  theme(
    axis.title.x = element_blank(),
    legend.title = element_blank(),
    axis.title.y = element_text(angle = 0,vjust = 0.5),
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold")
  ) -> b
b

ggsave("wykres2.jpeg", b)
