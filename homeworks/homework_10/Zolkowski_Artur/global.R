library("readxl")
library(dplyr)



readAchievement <- function(path, n){
  df <- read_xlsx(path, skip = 4) %>%
    select(3, 5) %>%
    filter(Country != "TIMSS Scale Centerpoint") %>% 
    rename("Score" = "Average \r\nScale Score") %>%
    na.omit()
  df <- df[1:n,]
  df %>% arrange(desc(Score))
}
M4 <-  readAchievement("./data/1-1_achievement-results-M4.xlsx", 58)
S4 <-  readAchievement("./data/2-1_achievement-results-S4.xlsx", 58)
M8 <- readAchievement("./data/3-1_achievement-results-M8.xlsx", 39)
S8 <- readAchievement("./data/4-1_achievement-results-S8.xlsx", 39)

readAchievementGender <- function(path, n){
  df <- read_xlsx(path, skip = 5) %>%
    select(3, 8, 14) %>%
    rename("Country"="...3", "Girls"="Average\r\nScale Score...8", "Boys"="Average\r\nScale Score...14") %>% 
    na.omit()
  df <- df[1:n,]
}

M4Gender <- readAchievementGender("./data/1-5_achievement-gender-M4.xlsx", 58)
S4Gender <- readAchievementGender("./data/2-5_achievement-gender-S4.xlsx", 58)
M8Gender <- readAchievementGender("./data/3-5_achievement-gender-M8.xlsx", 39)
S8Gender <- readAchievementGender("./data/4-5_achievement-gender-S8.xlsx", 39)
tail(S8Gender,10)
readLikeLearning <- function(path, n){
  df <- read_xlsx(path, skip = 5) %>%
    select(3,24) %>% 
    rename("Score" = "...24", "Country"="...3") %>%
    na.omit()
  df <- df[1:n,]
}

M4learning <- readLikeLearning("./data/11-2_students-like-learning-M4.xlsx", 58)
S4learning <- readLikeLearning("./data/11-5_students-like-learning-S4.xlsx", 58)
M8learning <- readLikeLearning("./data/11-3_students-like-learning-M8.xlsx", 26)
S8learning <- readLikeLearning("./data/11-6_students-like-learning-S8.xlsx", 26)


M4 <- M4 %>% left_join(M4Gender)
S4 <- S4 %>% left_join(S4Gender)
M8 <- M8 %>% left_join(M8Gender)
S8 <- S8 %>% left_join(S8Gender)
