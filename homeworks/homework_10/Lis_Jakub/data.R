library(dplyr)
library(xlsx)

trends_M4 <- read.xlsx(file = 'data/1-3_achievement-trends-M4.xlsx',
                      sheetIndex = 1,
                      startRow = 6,
                      colIndex = seq(3, 15, 2)) %>%
  filter(!is.na(Country))

trends_S4 <- read.xlsx(file = 'data/2-3_achievement-trends-S4.xlsx',
                       sheetIndex = 1,
                       startRow = 6,
                       colIndex = c(3, 4, 6, 8, 10, 12, 14)) %>%
  filter(!is.na(Country))

trends_M8 <- read.xlsx(file = 'data/3-3_achievement-trends-M8.xlsx',
                       sheetIndex = 1,
                       startRow = 6,
                       colIndex = seq(3, 15, 2)) %>%
  filter(!is.na(Country))

trends_S8 <- read.xlsx(file = 'data/4-3_achievement-trends-S8.xlsx',
                       sheetIndex = 1,
                       startRow = 6,
                       colIndex = seq(3, 15, 2)) %>%
  filter(!is.na(Country))


freq_M4 <- read.xlsx(file = 'data/10-1_challenges-absenteeism-M4.xlsx',
                     sheetIndex = 1,
                     startRow = 6,
                     colIndex = seq(3, 33, 3))

freq_S4 <- read.xlsx(file = 'data/10-2_challenges-absenteeism-S4.xlsx',
                     sheetIndex = 1,
                     startRow = 6,
                     colIndex = seq(3, 33, 3))

freq_M8 <- read.xlsx(file = 'data/10-3_challenges-absenteeism-M8.xlsx',
                     sheetIndex = 1,
                     startRow = 6,
                     colIndex = seq(3, 33, 3))

freq_S8 <- read.xlsx(file = 'data/10-4_challenges-absenteeism-S8.xlsx',
                     sheetIndex = 1,
                     startRow = 6,
                     colIndex = seq(3, 33, 3))

names(freq_M4) <- c(
  "Country", "Per_Never", "Avg_Never", "Per_OnceTwoMonth", "Avg_OnceTwoMonth", 
  "Per_OnceAMonth", "Avg_OnceAMonth", "Per_OnceTwoWeek", "Avg_OnceTwoWeek",
  "Per_OnceAWeek", "Avg_OnceAWeek"
)
names(freq_S4) <- c(
  "Country", "Per_Never", "Avg_Never", "Per_OnceTwoMonth", "Avg_OnceTwoMonth", 
  "Per_OnceAMonth", "Avg_OnceAMonth", "Per_OnceTwoWeek", "Avg_OnceTwoWeek",
  "Per_OnceAWeek", "Avg_OnceAWeek"
)
names(freq_M8) <- c(
  "Country", "Per_Never", "Avg_Never", "Per_OnceTwoMonth", "Avg_OnceTwoMonth", 
  "Per_OnceAMonth", "Avg_OnceAMonth", "Per_OnceTwoWeek", "Avg_OnceTwoWeek",
  "Per_OnceAWeek", "Avg_OnceAWeek"
)
names(freq_S8) <- c(
  "Country", "Per_Never", "Avg_Never", "Per_OnceTwoMonth", "Avg_OnceTwoMonth", 
  "Per_OnceAMonth", "Avg_OnceAMonth", "Per_OnceTwoWeek", "Avg_OnceTwoWeek",
  "Per_OnceAWeek", "Avg_OnceAWeek"
)

freq_M4 <- freq_M4 %>% filter(!is.na(Country))
freq_M4 <- data.frame(lapply(freq_M4, function(x) {
  gsub("~", NA, x)
}))

freq_S4 <- freq_S4 %>% filter(!is.na(Country))
freq_S4 <- data.frame(lapply(freq_S4, function(x) {
  gsub("~", NA, x)
}))

freq_M8 <- freq_M8 %>% filter(!is.na(Country))
freq_M8 <- data.frame(lapply(freq_M8, function(x) {
  gsub("~", NA, x)
}))

freq_S8 <- freq_S8 %>% filter(!is.na(Country))
freq_S8 <- data.frame(lapply(freq_S8, function(x) {
  gsub("~", NA, x)
}))



