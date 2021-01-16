library("readxl")
library(dplyr)


# Matematyka dla 4 klasy
M4 <- readxl::read_xlsx("./Data/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()


S4 <- readxl::read_xlsx("./Data/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()


MS4 <- merge(M4, S4, by.x = "Country", by.y = "Country")
colnames(MS4) <- c("Country", "Score.Math", "Score.Science")
MS4$Diffrence <- MS4$Score.Math - MS4$Score.Science
MS4 <- MS4[order(MS4$Dif), ]
MS4$Nr <- 1:length(MS4$Dif)
MS4$Color <- MS4$Dif > 0

M4 <- data.frame(M4, stringsAsFactors = F)
M4 <- M4[order(M4$Score), ]
M4 <- data.frame(M4, Nr = length(M4$Country):1)
row.names(M4) <- M4$Nr
M4$Country <- factor(M4$Country, levels = unique(M4$Country)[order(M4$Score, decreasing = T)])

# Przyroda dla 4 klasy
# S4 <- read_xlsx("./Data/2-1_achievement-results-S4.xlsx", skip = 4) %>%
#   select(3, 5) %>%
#   rename("Score" = "Average \r\nScale Score") %>%
#   na.omit()

S4 <- data.frame(S4, stringsAsFactors = F)
S4 <- S4[order(S4$Score), ]
S4 <- data.frame(S4, Nr = length(S4$Country):1)
row.names(S4) <- S4$Nr
S4$Country <- factor(S4$Country, levels = unique(S4$Country)[order(S4$Score, decreasing = T)])

#write.csv(M4, "./Data/M4.csv")
#write.csv(S4, "./Data/S4.csv")
#write.csv(MS4, "./Data/MS4.csv")

