library(dplyr)
library("readxl")
library(plotly)

M4_results <- read_xlsx("TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(M4_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")


S4_results <- read_xlsx("TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(S4_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")


M8_results <- read_xlsx("TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(M8_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")



S8_results <- read_xlsx("TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(S8_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")






M4_trends <- read_xlsx("TIMSS-2019/1-3_achievement-trends-M4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15)


colnames(M4_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
M4_trends <- M4_trends %>% filter(!is.na(Country))



M8_trends <- read_xlsx("TIMSS-2019/3-3_achievement-trends-M8.xlsx", skip = 4) %>%
  select(2, 4, 6, 8, 10, 12, 14) 


colnames(M8_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
M8_trends <- M8_trends %>% filter(!is.na(Country))


S4_trends <- read_xlsx("TIMSS-2019/2-3_achievement-trends-S4.xlsx", skip = 4) %>%
  select(3, 4, 6, 8, 10, 12, 14) 


colnames(S4_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
S4_trends <- S4_trends %>% filter(!is.na(Country))


S8_trends <- read_xlsx("TIMSS-2019/4-3_achievement-trends-S8.xlsx", skip = 4) %>%
  select(2, 4, 6, 8, 10, 12, 14) 


colnames(S8_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
S8_trends <- S8_trends %>% filter(!is.na(Country))


