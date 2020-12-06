library(dplyr)
library(ggplot2)

przypadki <- read.csv('dane/dzienne_przypadki.csv', sep = ',', colClasses=c("Date", "integer"))
wirus <- read.csv('dane/trends_wirus.csv', sep = ',', colClasses=c("Date", "double"))
lockdown <- read.csv('dane/trends_lockdown.csv', sep = ',', colClasses=c("Date", "double"))

przypadki <- head(przypadki, 261)
maksimum <- max(przypadki[2])
przypadki[2] <- przypadki[2]*100/maksimum

wirus <- rename(wirus, Data = 1)
lockdown <- rename(lockdown, Data = 1)
przypadki <- left_join(przypadki, wirus)
przypadki <- left_join(przypadki, lockdown)

ggplot(przypadki, aes(x = Data, color = Legenda)) +
  geom_line(aes(y = Przypadki, color = 'Zachorowania'), size = 1, alpha = 0.8) +
  geom_line(aes(y = wirus, color = 'trends: wirus'), size = 1, alpha = 0.8) +
  geom_line(aes(y = lockdown, color = 'trends: lockdown'), size = 1, alpha = 0.8) +
  theme_bw() +
  scale_color_manual(values = c(
    'Zachorowania' = 'red',
    'trends: wirus' = 'blue',
    'trends: lockdown' = 'gold'))

ggsave(filename = 'wykresy/Trendsy.png', width = 11, height = 8)