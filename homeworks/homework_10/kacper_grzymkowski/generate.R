library("readxl")
library(dplyr)

M4 <- read_xlsx("TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

S4 <- read_xlsx("TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

M8 <- read_xlsx("TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

S8 <- read_xlsx("TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()


write.csv(M4, "m4.csv", row.names = F)
write.csv(S4, "s4.csv", row.names = F)

write.csv(M8, "m8.csv", row.names = F)
write.csv(S8, "s8.csv", row.names = F)

