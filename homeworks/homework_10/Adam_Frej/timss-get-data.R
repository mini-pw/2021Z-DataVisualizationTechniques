library(readxl)
library(dplyr)


# Matematyka dla 4 klasy
# M4 <- read_xlsx("pd_10/data/TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
#   select(3, 5) %>%
#   rename("Score" = "Average \r\nScale Score") %>%
#   na.omit()
# M4 = as.data.frame(M4)

# Dla 8 klasy bedzie:
# 3-1_achievement-results-M8.xlsx

# Przyroda dla 4 klasy
# S4 <- read_xlsx("pd_10/data/TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
#   select(3, 5) %>%
#   rename("Score" = "Average \r\nScale Score") %>%
#   na.omit()
# S4 = as.data.frame(S4)

# Dla 8 klasy bedzie:
# 4-1_achievement-results-S8.xls


# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie.

M4 <- read_xlsx("pd_10/data/TIMSS-2019/1-3_achievement-trends-M4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15) %>%
  rename("MScore2019all" = 2, "MScore2015all" = 3, "MScore2011all" = 4, "MScore2007all" = 5, 
         "MScore2003all" = 6, "MScore1995all" = 7)
M4 = as.data.frame(M4)
M4 <- subset(M4, !is.na(Country))

M4gender <- read_xlsx("pd_10/data/TIMSS-2019/1-6_achievement-gender-trends-M4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27) %>%
  rename("MScore2019girls" = 2, "MScore2019boys" = 3, "MScore2015girls" = 4, "MScore2015boys" = 5, 
         "MScore2011girls" = 6, "MScore2011boys" = 7, "MScore2007girls" = 8, "MScore2007boys" = 9, 
         "MScore2003girls" = 10, "MScore2003boys" = 11, "MScore1995girls" = 12, "MScore1995boys" = 13)
M4gender <- as.data.frame(M4gender)
M4gender <- subset(M4gender, !is.na(Country))

full_join(M4, M4gender) -> M4
M4[is.na(M4)] = 0
cols_to_change <- c("MScore2019girls", "MScore2019boys", "MScore2015girls", "MScore2015boys", 
                    "MScore2011girls", "MScore2011boys", "MScore2007girls", "MScore2007boys", 
                    "MScore2003girls", "MScore2003boys", "MScore1995girls", "MScore1995boys")
M4[cols_to_change] <- sapply(M4[cols_to_change],as.numeric)


S4 <- read_xlsx("pd_10/data/TIMSS-2019/2-3_achievement-trends-S4.xlsx", skip = 4) %>%
  select(3, 4, 6, 8, 10, 12, 14) %>%
  rename("SScore2019all" = 2, "SScore2015all" = 3, "SScore2011all" = 4, "SScore2007all" = 5, 
         "SScore2003all" = 6, "SScore1995all" = 7)
S4 = as.data.frame(S4)
S4 <- subset(S4, !is.na(Country))

S4gender <- read_xlsx("pd_10/data/TIMSS-2019/2-6_achievement-gender-trends-S4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27) %>%
  rename("SScore2019girls" = 2, "SScore2019boys" = 3, "SScore2015girls" = 4, "SScore2015boys" = 5, 
         "SScore2011girls" = 6, "SScore2011boys" = 7, "SScore2007girls" = 8, "SScore2007boys" = 9, 
         "SScore2003girls" = 10, "SScore2003boys" = 11, "SScore1995girls" = 12, "SScore1995boys" = 13)
S4gender <- as.data.frame(S4gender)
S4gender <- subset(S4gender, !is.na(Country))

full_join(S4, S4gender) -> S4
S4[is.na(S4)] = 0
cols_to_change <- c("SScore2019girls", "SScore2019boys", "SScore2015girls", "SScore2015boys", 
                    "SScore2011girls", "SScore2011boys", "SScore2007girls", "SScore2007boys", 
                    "SScore2003girls", "SScore2003boys", "SScore1995girls", "SScore1995boys")
S4[cols_to_change] <- sapply(S4[cols_to_change],as.numeric)


Data <- full_join(M4, S4)
Data[is.na(Data)] = 0
write.csv2(Data, "pd_10/TIMSS_2019/Data.csv")